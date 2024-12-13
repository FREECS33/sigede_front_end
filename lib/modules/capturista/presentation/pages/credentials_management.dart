import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';

class CredentialsScreen extends StatefulWidget {
  const CredentialsScreen({super.key});

  @override
  _CredentialsScreenState createState() => _CredentialsScreenState();
}

class _CredentialsScreenState extends State<CredentialsScreen> {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? ''));
  List<Map<String, dynamic>> credentials = [];
  bool _isLoading = true;
  int? userAccountId;

  @override
  void initState() {
    super.initState();
    _loadCapturerId();
  }

  Future<void> _loadCapturerId() async {
    userAccountId = await TokenService.getUserId();
    print(userAccountId);
    if (userAccountId != null) {
      _fetchCredentials();
    } else {
      await showErrorDialog(
        context: context,
        message: 'Error: Capturer ID no está disponible.',
      );
    }
  }

  Future<void> _fetchCredentials() async {
    try {
      final response = await _dio.get('/api/credentials/capturist/$userAccountId');

      if (response.statusCode == 200) {
        setState(() {
          credentials = List<Map<String, dynamic>>.from(response.data.map((item) => {
            'credentialId': item['credentialId'],
            'fullname': item['fullname'],
            'userPhoto': item['userPhoto'],
            'expirationDate': item['expirationDate']?.substring(0, 10),
          }));
          _isLoading = false;
        });
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400) {
        setState(() {
          credentials = [];
          _isLoading = false;
        });
      } else {
        await showErrorDialog(
          context: context,
          message: 'Error al cargar las credenciales: ${e.message}',
        );
        setState(() {
          _isLoading = false;
        });
      }
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Credenciales',
              style: TextStyle(
                fontFamily: 'RubikOne',
                fontSize: 37,
                height: 1.2,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Buscar credencial',
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFFF6F5F5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Color(0xFF917D62), width: 1.5),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.black),
                  )
                : Expanded(
                    child: credentials.isEmpty
                        ? const Center(
                            child: Text(
                              'No se encontraron credenciales.',
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: credentials.length,
                            itemBuilder: (context, index) {
                              final credential = credentials[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(credential['userPhoto'] ?? ''),
                                        radius: 30,
                                        onBackgroundImageError: (_, __) => const Icon(
                                          Icons.person,
                                          size: 60,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        credential['fullname'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Vigencia:',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        credential['expirationDate'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
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
