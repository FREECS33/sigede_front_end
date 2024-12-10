import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PreviewQR extends StatefulWidget {
  final int credentialId;
  const PreviewQR({super.key, required this.credentialId});

  @override
  State<PreviewQR> createState() => _PreviewQRState();
}

class _PreviewQRState extends State<PreviewQR> {
  bool isLoading = true;
  String? errorMessage;
  Map<String, dynamic>? credentialData;
  @override
  void initState() {
    super.initState();
    _loadCredentialData();
  }

   Future<void> _loadCredentialData() async {
    try {
      final response = await Dio().get(
        'http://localhost:8080/api/credentials/${widget.credentialId}',
      );
      setState(() {
        credentialData = response.data['data'];
        isLoading = false;
      });
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error al cargar la credencial";
      });
      debugPrint('DioError: ${e.type} - ${e.message}');
    }
  }

  String formatDate(String dateTime) {
    try {
      DateTime parsedDate = DateTime.parse(dateTime);
      return "${parsedDate.year}-${parsedDate.month.toString().padLeft(2, '0')}-${parsedDate.day.toString().padLeft(2, '0')}";
    } catch (e) {
      debugPrint("Error parsing date: $dateTime");
      return "Fecha inválida";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detalles Credencial',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  credentialData?['userPhoto'] ??
                                      'https://cdn.pixabay.com/photo/2024/07/22/17/11/elegance-in-profile-8913207_640.png'),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  credentialData?['fullname'] ?? 'Cargando...',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
  'Vigencia: ${credentialData != null && credentialData!['expirationDate'] != null ? formatDate(credentialData!['expirationDate']) : 'No disponible'}',
  style: const TextStyle(fontSize: 14),
),

                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        for (var field in credentialData?['fields'] ?? [])
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TextField(
                              controller: TextEditingController(
                                  text: field['value']),
                              readOnly: true,
                              decoration: InputDecoration(
                                labelText: field['tag'],
                                border: const OutlineInputBorder(),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}