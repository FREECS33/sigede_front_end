import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigede_flutter/core/utils/cloudinary_service.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class RegisterCredentialScreen extends StatefulWidget {
  const RegisterCredentialScreen({super.key});

  @override
  _RegisterCredentialScreenState createState() => _RegisterCredentialScreenState();
}

class _RegisterCredentialScreenState extends State<RegisterCredentialScreen> {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? ''));
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();

  List<Map<String, dynamic>> fields = [];
  File? _selectedImage;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadFields();
  }

  Future<void> _loadFields() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final institutionId = await TokenService.getInstituionId();
      if (institutionId == null) {
        throw Exception("Institution ID no encontrado.");
      }

      final response = await _dio.get('/api/user-info/get-institution-form/$institutionId');

      // Log del contenido de response.data
      print('Respuesta del backend: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final userInfo = List<Map<String, dynamic>>.from(response.data['userInfo'] ?? []);
        final fieldsData = List<Map<String, dynamic>>.from(response.data['fields'] ?? []);

        setState(() {
          fields = fieldsData.map((field) {
            final userInfoItem = userInfo.firstWhere(
              (info) => info['userInfoId'] == field['userInfoId'],
              orElse: () => {'tag': 'Campo desconocido', 'type': 'Texto'},
            );

            return {
              'tag': userInfoItem['tag'],
              'type': userInfoItem['type'],
              'required': field['required'],
              'value': '',
            };
          }).toList();
        });
      }
    } catch (e) {
      await showErrorDialog(context: context, message: 'Error al cargar los campos: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate() || _selectedImage == null) {
      await showErrorDialog(context: context, message: 'Por favor, completa todos los campos obligatorios.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final imageUrl = await _cloudinaryService.uploadImage(_selectedImage!);
      if (imageUrl == null) {
        throw Exception("Error al subir la imagen.");
      }

      final institutionId = await TokenService.getInstituionId();
      final userAccountId = await TokenService.getUserId();

      if (institutionId == null || userAccountId == null) {
        throw Exception("Datos del usuario o institución no disponibles.");
      }

      final formData = {
        'userAccountId': userAccountId,
        'institutionId': institutionId,
        'fullname': _fullnameController.text,
        'expirationDate': _expirationDateController.text,
        'userPhoto': imageUrl,
        'fields': fields.map((field) => {
          'tag': field['tag'],
          'value': field['value'],
        }).toList(),
      };

      await _dio.post('/api/credentials/new-credential', data: formData);

      await showSuccessDialog(context: context, message: 'Credencial registrada con éxito.');
      Navigator.of(context).pop();
    } catch (e) {
      await showErrorDialog(context: context, message: 'Error al registrar la credencial: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 30,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Colors.black),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Registrar Credencial',
                      style: TextStyle(
                        fontFamily: 'RubikOne',
                        fontSize: 37,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _fullnameController,
                          decoration: const InputDecoration(
                            labelText: 'Ingresa el nombre completo',
                            labelStyle: TextStyle(
                              fontFamily: 'RubikOne',
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _expirationDateController,
                          decoration: const InputDecoration(
                            labelText: 'Selecciona la fecha de expiración',
                            labelStyle: TextStyle(
                              fontFamily: 'RubikOne',
                              fontSize: 14,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _selectedImage == null
                            ? const Center(child: Text('Selecciona una imagen'))
                            : Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...fields.map((field) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 5),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Ingresa ${field['tag']}',
                                  labelStyle: const TextStyle(
                                    fontFamily: 'RubikOne',
                                    fontSize: 14,
                                  ),
                                  border: const OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  field['value'] = value;
                                },
                                validator: (value) {
                                  if (field['required'] && (value == null || value.isEmpty)) {
                                    return 'Este campo es obligatorio';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Registrar',
                            style: TextStyle(
                              fontFamily: 'RubikOne',
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              fontFamily: 'RubikOne',
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
