import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart'; // Agregar esto para la web
import 'package:sigede_flutter/core/utils/cloudinary_service.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:flutter/foundation.dart'; // Para detección de plataforma
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';

class RegisterCredential extends StatefulWidget {
  const RegisterCredential({super.key});

  @override
  State<RegisterCredential> createState() => _RegisterCredentialState();
}

class _RegisterCredentialState extends State<RegisterCredential> {
  dynamic _image;  // Se mantiene dinámico para poder manejar imágenes en diferentes plataformas
  final ImagePicker _picker = ImagePicker();
  List<dynamic> dynamicFields = [];
  List<dynamic> requiredFields = [];
  Map<String, TextEditingController> fieldControllers = {};
  String? fullname;
  String? institutionId;
  int? userAccountId;
  bool isLoading = true;
  String? errorMessage;

  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  // Obtener datos iniciales del usuario y el formulario dinámico
  Future<void> fetchInitialData() async {
    setState(() {
      isLoading = true;
    });
    try {
      final email = await TokenService.getUserEmail();
      final institutionId = await TokenService.getInstituionId();

      if (email == null || institutionId == null) {
        throw Exception("Faltan datos en SharedPreferences.");
      }

      // Obtener userAccountId con el email
      final userResponse = await _dio
          .get('http://localhost:8080/api/capturists/get-capturistId/$email');
      if (userResponse.statusCode != 200) {
        throw Exception("Error al obtener el ID de usuario.");
      }
      userAccountId = userResponse.data['userAccountId'];

      // Obtener formulario dinámico
      final formResponse = await _dio.get(
          'http://localhost:8080/api/user-info/get-institution-form/$institutionId');
      if (formResponse.statusCode != 200) {
        throw Exception("Error al obtener el formulario dinámico.");
      }

      final formData = formResponse.data;
      dynamicFields = formData['userInfo'];
      requiredFields = formData['fields']
          .where((field) => field['required'] == true)
          .toList();

      // Crear controladores para los campos dinámicos
      for (var field in dynamicFields) {
        fieldControllers[field['tag']] = TextEditingController();
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Selecciona una imagen (móvil o web)
  Future<void> _pickImage(ImageSource source) async {
    if (kIsWeb) {
      final pickedFile = await ImagePickerWeb.getImageAsFile();
      if (pickedFile != null) {
        setState(() {
          _image = pickedFile; // Guardamos la imagen en el formato web
        });
      }
    } else {
      final pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path); // Para móvil, usamos File
        });
      }
    }
  }

  // Registrar la credencial
  Future<void> registerCredential() async {
  if (fullname == null || fullname!.isEmpty || _image == null) {
    await showErrorDialog(
        context: context,
        message: "Nombre completo y foto son obligatorios.");
    return;
  }

  // Subir la imagen a Cloudinary (o cualquier otro servicio)
  String? imageUrl = await CloudinaryService().uploadImage(_image);
  if (imageUrl == null) {
    await showErrorDialog(
        context: context, message: "Error al subir la imagen.");
    return;
  }

  final fields = dynamicFields.map((field) {
    return {
      "tag": field['tag'],
      "value": fieldControllers[field['tag']]?.text ?? ""
    };
  }).toList();

  // Validar campos obligatorios dinámicos
  final missingRequiredFields = requiredFields.where((requiredField) {
    final tag = dynamicFields.firstWhere(
        (dynamicField) =>
            dynamicField['userInfoId'] == requiredField['userInfoId'],
        orElse: () => {})['tag'];
    return tag != null && (fieldControllers[tag]?.text ?? "").isEmpty;
  }).toList();

  if (missingRequiredFields.isNotEmpty) {
    showErrorDialog(
        context: context, message: "Hay campos obligatorios sin completar.");
    return;
  }

  try {
    final requestPayload = {
      "fullname": fullname,
      "userPhoto": imageUrl, // Enviar la URL de la imagen subida
      "institutionId": int.parse(institutionId!),
      "userAccountId": userAccountId,
      "fields": fields,
    };

    final response = await _dio.post(
      'http://localhost:8080/api/credentials/new-credential',
      data: requestPayload,
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registro exitoso')),
      );
    } else {
      throw Exception("Error al registrar la credencial.");
    }
  } catch (e) {
    setState(() {
      errorMessage = e.toString();
    });
  }
}


  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Registrar Credencial',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Registrar Credencial',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Center(child: Text(errorMessage!)),
      );
    }

    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Registrar Credencial',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior
              .onDrag, // Para cerrar el teclado al arrastrar
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 120,
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: [
                                const Text('Selecciona una opción'),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.camera);
                                      },
                                      label: const Text('Cámara'),
                                      icon: const Icon(Icons.camera),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.gallery);
                                      },
                                      label: const Text('Galería'),
                                      icon: const Icon(Icons.photo_library),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: _image == null
                          ? const Icon(Icons.add_a_photo,
                              size: 50, color: Colors.grey)
                          : kIsWeb
                              ? Image.network(
                                  _image.toString(), // Usar la URL de la imagen subida
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  _image is File ? _image : File(''),
                                  fit: BoxFit.cover,
                                ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre completo',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Este campo es obligatorio.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      fullname = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  ...dynamicFields.map((field) {
                    final isRequired = requiredFields.any((requiredField) =>
                        requiredField['userInfoId'] == field['userInfoId']);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: TextFormField(
                        controller: fieldControllers[field['tag']],
                        decoration: InputDecoration(
                          labelText:
                              isRequired ? '${field['tag']} *' : field['tag'],
                        ),
                        validator: (value) {
                          if (isRequired && (value == null || value.isEmpty)) {
                            return 'Este campo es obligatorio.';
                          }
                          return null;
                        },
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          registerCredential();
                        }
                      },
                      child: const Text('Registrar'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
