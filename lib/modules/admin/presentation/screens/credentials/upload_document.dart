import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class UploadDocument extends StatefulWidget {
  const UploadDocument({super.key});

  @override
  State<UploadDocument> createState() => _UploadDocumentState();
}

class _UploadDocumentState extends State<UploadDocument> {
  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=kvj0__KPcFE');
  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
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
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Instrucciones para Subir tu Plantilla',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'RubikOne',
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),
              const Text(
                'Para generar documentos correctamente, asegúrate de que tu plantilla cumpla con los siguientes requisitos:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Requisitos del Documento:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 236, 63, 10)),
              ),
              const SizedBox(height: 8),
              // Lista de requisitos
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                'El documento debe estar en formato .docx.')),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                'Incluye etiquetas para datos dinámicos:')),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text('\$name: Nombre del usuario.',
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                        ListTile(
                          title: Text('\$expirationDate: Fecha de expiración.',
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                        ListTile(
                          title: Text(
                            '\$tag: Campos dinámicos de la credencial. (Reemplaza "tag" por los campos que registraste en tu formulario).',
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: Row(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                'Para insertar imágenes, usa marcadores de posición con texto alternativo:')),
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                              'PERSON_IMAGE: Imagen de perfil del usuario.',
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                        ListTile(
                          title: Text('QR_CODE: Código QR dinámico.',
                              style: TextStyle(color: Colors.blueAccent)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Recuerda que esta función solo esta disponible para usuarios con rol de administrador en la aplicación web.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              
            ],
          ),
        ),
      ),
    );
  }
}
