import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/core/utils/cloudinary_service.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:intl/intl.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class EditCredentialScreen extends StatefulWidget {
  final int credentialId;

  const EditCredentialScreen({required this.credentialId, Key? key}) : super(key: key);

  @override
  _EditCredentialScreenState createState() => _EditCredentialScreenState();
}

class _EditCredentialScreenState extends State<EditCredentialScreen> {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? ''));
  final CloudinaryService _cloudinaryService = CloudinaryService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();

  List<Map<String, dynamic>> fields = [];
  File? _selectedImage;
  String? _imageUrl;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCredentialDetails();
  }

Future<void> _loadCredentialDetails() async {
  setState(() {
    _isLoading = true;
  });

  try {
    if (widget.credentialId == null) {
      throw Exception('El ID de la credencial es nulo.');
    }

    final response = await _dio.get('/api/credentials/${widget.credentialId}');

    if (response.statusCode == 200 && response.data != null) {
      final credentialData = response.data;

      setState(() {
        _fullnameController.text = credentialData['fullname'] ?? '';
        _expirationDateController.text = credentialData['expirationDate'] ?? '';
        _imageUrl = credentialData['userPhoto'];
        fields = List<Map<String, dynamic>>.from(credentialData['fields'] ?? []).map((field) {
          return {
            'tag': field['tag'],
            'value': field['value'] ?? '',
          };
        }).toList();
      });
    } else {
      throw Exception('Datos de la credencial no encontrados.');
    }
  } catch (e) {
    await showErrorDialog(context: context, message: 'Error al cargar los detalles: $e');
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  Future<void> _selectExpirationDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (selectedTime != null) {
        final combinedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss.000000').format(combinedDateTime);
        setState(() {
          _expirationDateController.text = formattedDate;
        });
      }
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

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) {
      await showErrorDialog(context: context, message: 'Por favor, completa todos los campos obligatorios.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      String? uploadedImageUrl = _imageUrl;

      if (_selectedImage != null) {
        uploadedImageUrl = await _cloudinaryService.uploadImage(_selectedImage!);
        if (uploadedImageUrl == null) {
          throw Exception('Error al subir la imagen.');
        }
      }

      final updatedData = {
        'fullname': _fullnameController.text,
        'userPhoto': uploadedImageUrl,
        'expirationDate': _expirationDateController.text,
        'fields': fields.map((field) => {
          'tag': field['tag'],
          'value': field['value'],
        }).toList(),
      };

      await _dio.put('/api/credentials/${widget.credentialId}', data: updatedData);

      await showSuccessDialog(context: context, message: 'Cambios guardados con éxito.');
      Navigator.of(context).pop();
    } catch (e) {
      await showErrorDialog(context: context, message: 'Error al guardar los cambios: $e');
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
                      'Editar Credencial',
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
                        const Text(
                          'Nombre Completo',
                          style: TextStyle(
                            fontFamily: 'RubikOne',
                            fontSize: 14,
                          ),
                        ),
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
                        const Text(
                          'Fecha de Expiración',
                          style: TextStyle(
                            fontFamily: 'RubikOne',
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          controller: _expirationDateController,
                          readOnly: true,
                          onTap: _selectExpirationDate,
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
                            ? (_imageUrl == null
                                ? const Center(child: Text('Selecciona una imagen'))
                                : Image.network(
                                    _imageUrl!,
                                    fit: BoxFit.cover,
                                  ))
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
                              Text(
                                field['tag'],
                                style: const TextStyle(
                                  fontFamily: 'RubikOne',
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 5),
                              TextFormField(
                                initialValue: field['value'],
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
                              ),
                            ],
                          ),
                        )),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _saveChanges,
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50),
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          child: const Text(
                            'Guardar',
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
