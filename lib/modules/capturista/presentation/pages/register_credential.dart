import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class RegisterCredential extends StatefulWidget {
  const RegisterCredential({super.key});

  @override
  State<RegisterCredential> createState() => _RegisterCredential();
}

class _RegisterCredential extends State<RegisterCredential> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar una foto'),
                onTap: () async {
                  final XFile? photo =
                      await _picker.pickImage(source: ImageSource.camera);
                  setState(() => _image = photo);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar desde galería'),
                onTap: () async {
                  final XFile? photo =
                      await _picker.pickImage(source: ImageSource.gallery);
                  setState(() => _image = photo);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _showImagePickerOptions,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: _image != null
                ? ClipOval(
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  )
                : const Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.white,
                  ),
          ),
        ),
        if (_image != null)
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text('Imagen seleccionada: ${_image!.name}'),
          ),
      ],
    );
  }
}