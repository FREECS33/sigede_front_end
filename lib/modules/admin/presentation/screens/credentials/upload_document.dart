import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({super.key});

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 30,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [Text('Hola')],
      ),
    );
  }
  /*
  File? _file;
  String? _fileName;
  bool _isLoading = false;
  // Función para seleccionar el archivo Word
  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['doc','docs','docx'],
    );

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
        _fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 30,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const Text('Hola'),
                  // Botón para subir el archivo
                  GestureDetector(
                    onTap: _pickFile,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.black),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.upload_file,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Nombre del archivo seleccionado
                  if (_fileName != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.brown[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Lista de campos\n$_fileName',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Spacer(),

                  // Botón para guardar
                  Padding(
                    padding: const EdgeInsets.only(bottom: 140.0),
                    child: SizedBox(
                      width: 300,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_file != null) {
                            print('Archivo cargado: ${_file!.path}');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                        child: _isLoading
                            ? const LoadingWidget() // Mostrar loading si está cargando
                            : Text(
                                'Guardar',
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
            ),
          ),
        ),
      ),
    );
  }
  */
}
