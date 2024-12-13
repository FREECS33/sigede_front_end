import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';

class CredentialDetail extends StatefulWidget {
  final int? credentialId;
  final String? userPhoto;
  final String? fullname;
  final DateTime? expirationDate;
  const CredentialDetail(
      {super.key,
      this.credentialId,
      this.userPhoto,
      this.fullname,
      this.expirationDate});

  @override
  State<CredentialDetail> createState() => _CredentialDetailState();
}

class _CredentialDetailState extends State<CredentialDetail> {
  final DioClient _dioClient = DioClient();
  bool _isLoading = false;
  bool _notData = false;
  Map<String, dynamic>? _credentialData;
  @override
  void initState() {
    super.initState();
    getCredential();
  }

  Future<void> getCredential() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await _dioClient.dio.get('/api/credentials/${widget.credentialId}');
      if (response.statusCode == 200) {
        setState(() {
          _credentialData = response.data['data'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
          _notData = true;
        });
        showErrorDialog(
            context: context,
            message: 'No se pudo obtener la información de la credencial');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _notData = true;
      });
      showErrorDialog(
          context: context,
          message: 'No se pudo obtener la información de la credencial');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la credencial',
            style: const TextStyle(color: Colors.black,fontFamily: 'RubikOne')),
        centerTitle: true,
        elevation: 0,
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Expanded(
                child: Center(
                  child: CircularProgressIndicator(color: Colors.black),
                ),
              )
            : _notData
                ? const Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 60,
                            color: Colors.grey,
                          ),
                          Text(
                            "No se encontraron datos",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                _credentialData?['userPhoto'] ?? ''),
                          ),
                          // Mostrar nombre completo
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    _credentialData?['fullname'] ??
                                        'Nombre no disponible',
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),

                                  // Mostrar fecha de expiración
                                  Text(
                                    'Vigencia: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(_credentialData?['expirationDate'])) ?? 'Fecha no disponible'}',
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      // Mostrar la imagen de usuario

                      const SizedBox(height: 16),
                      // Mostrar los campos dinámicos
                      Expanded(
                        child: ListView.builder(
                          itemCount: _credentialData?['fields']?.length ?? 0,
                          itemBuilder: (context, index) {
                            var field = _credentialData?['fields'][index];
                            return Card(
                              color: const Color(0xFFF6F5F5),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Color(0xFF917D62), // Color del borde
                                  width: 1.5, // Grosor del borde
                                ),
                              ),
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                    field['tag'] ?? 'Etiqueta desconocida'),
                                subtitle:
                                    Text(field['value'] ?? 'Valor desconocido'),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
