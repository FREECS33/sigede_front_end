import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class RegisterInstitution extends StatefulWidget {
  const RegisterInstitution({super.key});

  @override
  _RegisterInstitutionState createState() => _RegisterInstitutionState();
}

class _RegisterInstitutionState extends State<RegisterInstitution> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameInstController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  XFile? _image;
  bool _isloading = false;
  bool _isValidName = true;
  int _currentStep = 0;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isloading = true;
    });

    // Simulando la subida de la imagen (puedes usar tu lógica aquí)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isloading = false;
      _currentStep = 1; // Cambia al segundo paso
    });
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    }
    return null;
  }

  Widget buildFirstStep() {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Spacer(),
            Text(
              "Paso 1 de 2",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Registrar cliente',
            style: GoogleFonts.rubikMonoOne(
              textStyle: const TextStyle(fontSize: 30, height: 1.2),
            ),
          ),
          const SizedBox(height: 35),
          Form(
            key: _formKey,
            child: GestureDetector(
              onTap: _pickImage,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _image == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 30, color: Colors.grey),
                            SizedBox(height: 5),
                            Icon(Icons.add, size: 20, color: Colors.grey),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                        ),
                ),
                const SizedBox(height: 35),
                TextFormField(
                  validator: validateName,
                  controller: _nameInstController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la institución',
                    labelStyle: TextStyle(
                      color: _isValidName
                          ? Colors.grey // Si la validación es exitosa
                          : Colors.red, // Si la validación falla
                    ),
                    suffixIcon: Icon(
                      Icons.apartment,
                      color: _isValidName ? Colors.grey : Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: validateName,
                  controller: _nameInstController,
                  decoration: InputDecoration(
                    labelText: 'Dirección',
                    labelStyle: TextStyle(
                      color: _isValidName
                          ? Colors.grey // Si la validación es exitosa
                          : Colors.red, // Si la validación falla
                    ),
                    suffixIcon: Icon(
                      Icons.pin_drop_outlined,
                      color: _isValidName ? Colors.grey : Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: validateName,
                  controller: _nameInstController,
                  decoration: InputDecoration(
                    labelText: 'Correo electrónico',
                    labelStyle: TextStyle(
                      color: _isValidName
                          ? Colors.grey // Si la validación es exitosa
                          : Colors.red, // Si la validación falla
                    ),
                    suffixIcon: Icon(
                      Icons.mail_outline,
                      color: _isValidName ? Colors.grey : Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  validator: validateName,
                  controller: _nameInstController,
                  decoration: InputDecoration(
                    labelText: 'Número telefónico',
                    labelStyle: TextStyle(
                      color: _isValidName
                          ? Colors.grey // Si la validación es exitosa
                          : Colors.red, // Si la validación falla
                    ),
                    suffixIcon: Icon(
                      Icons.phone_outlined,
                      color: _isValidName ? Colors.grey : Colors.red,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const Expanded(child: Column()),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: _isloading ? null : _uploadImage,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: _isloading
                    ? const LoadingWidget() // Mostrar loading si está cargando
                    : Text(
                        'Paso 2',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSecondStep() {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Spacer(),
            Text(
              "Paso 2 de 2",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Paso 2',
              style: GoogleFonts.roboto(
                textStyle:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Aquí va el contenido del segundo paso'),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _currentStep = 0; // Regresa al paso 1 si es necesario
                });
              },
              child: const Text('Regresar al Paso 1'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _currentStep == 0 ? buildFirstStep() : buildSecondStep(),
      ),
    );
  }
}
