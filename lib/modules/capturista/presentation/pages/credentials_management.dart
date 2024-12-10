import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/modules/capturista/data/models/credential_model.dart';
import 'package:sigede_flutter/modules/capturista/domain/use_cases/get_credentials.dart';
import 'package:sigede_flutter/modules/public/preview_qr.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';

class CredentialsManagement extends StatefulWidget {
  const CredentialsManagement({super.key});

  @override
  State<CredentialsManagement> createState() => _CredentialsManagementState();
}

class _CredentialsManagementState extends State<CredentialsManagement> {
  late GetCredentials getCredentials;
  List<CredentialModel> credencials = [];
  List<CredentialModel> filteredCredentials = [];
  bool isLoading = true;
  String? errorMessage;
  TextEditingController searchController = TextEditingController();
  String? institutionName;
  String? institutionLogo;

  @override
  void initState() {
    super.initState();
    getCredentials = locator<GetCredentials>();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    try {
      final institutionId = await TokenService.getInstituionId();
      if (institutionId == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'No se encontró el ID de la institución.';
        });
        return;
      }
      final institutionResponse = await Dio().get(
        'http://localhost:8080/api/institutions/$institutionId',
      );
      final institutionData = institutionResponse.data['data'];
      setState(() {
        institutionName = institutionData['name'];
        institutionLogo = institutionData['logo'];
      });

      final result = await getCredentials.call(institutionId: 1);
      setState(() {
        credencials = result;
        filteredCredentials = credencials; // Inicialmente muestra todas
        isLoading = false;
        if (credencials.isEmpty) {
          errorMessage = 'No hay credenciales registradas';
        }
      });
    } on DioException catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = "Error al cargar las credenciales";
      });
      debugPrint('DioError: ${e.type} - ${e.message}');
      if (e.response != null) {
        debugPrint('DioError response: ${e.response!.data}');
        debugPrint('DioError status code: ${e.response!.statusCode}');
      } else {
        debugPrint('DioError no response: ${e.error}');
      }
    }
  }

  void _filterCredentials(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCredentials = credencials;
      } else {
        filteredCredentials = credencials
            .where((credential) =>
                credential.fullname.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  Color _getVigenciaColor(String vigencia) {
    DateTime fechaVigencia = DateTime.parse(vigencia);
    DateTime fechaActual = DateTime.now();
    return fechaVigencia.isBefore(fechaActual) ? Colors.red : Colors.green;
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
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Credenciales',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: institutionLogo != null
                          ? Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Logo-utez.png/460px-Logo-utez.png',
                              height: 90,
                              width: 110,
                            )
                          : const SizedBox.shrink()),
                  const SizedBox(width: 8.0),
                  Expanded(
                    flex: 2,
                    child: Text(
                      institutionName ?? 'Cargando...',
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _filterCredentials(searchController.text);
                          },
                          icon: const Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        hintText: 'Buscar credencial',
                        labelText: 'Buscar credencial',
                      ),
                      onChanged: (value) => _filterCredentials(value),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 60,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    )
                  ],
                ),
              )
            else if (filteredCredentials.isEmpty)
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 60,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No se encontraron credenciales.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              )
            else
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 3 / 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: filteredCredentials.length,
                    itemBuilder: (context, index) {
                      final credential = filteredCredentials[index];
                      return InkWell(
                        onTap: () {
                          print('ID Credencial: ${credential.credentialId}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreviewQR(
                                  credentialId: credential.credentialId),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.badge_outlined),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        credential.fullname,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Vigencia'),
                                          Text(
                                            formatDate(
                                                credential.expirationDate),
                                            style: TextStyle(
                                              color: _getVigenciaColor(
                                                  credential.expirationDate),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
