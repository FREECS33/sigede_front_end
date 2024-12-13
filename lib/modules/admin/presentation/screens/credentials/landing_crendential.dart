import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/credential_detail.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/upload_document.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:intl/intl.dart';

class LandingCrendential extends StatefulWidget {
  const LandingCrendential({super.key});

  @override
  State<LandingCrendential> createState() => _LandingCrendentialState();
}

class _LandingCrendentialState extends State<LandingCrendential> {
  final dioClient = DioClient();
  List credenciales = [
    {
      'credentialId': 1,
      'userPhoto':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'fullname': 'Nombre del usuario',
      'expirationDate': DateTime.now(),
    },
    {
      'credentialId': 2,
      'userPhoto':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'fullname': 'Nombre del usuario',
      'expirationDate': DateTime.now(),
    },
    {
      'credentialId': 3,
      'userPhoto':
          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
      'fullname': 'Nombre del usuario',
      'expirationDate': DateTime.now(),
    },
  ];
  int? institutionId;
  String? fullname;
  String? baseUrl;
  String? logo;
  String? name;
  bool _isLoading = false;
  bool _notData = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await loadData();
      await getCredenciales();
    });
  }

  Future<void> loadData() async {
    institutionId = await TokenService.getInstituionId();
    fullname = await TokenService.getInstitutionName();
    logo = await TokenService.getLogo();
    name = await TokenService.getInstitutionName();
    baseUrl = dotenv.env['BASE_URL'];
  }

  Future<void> getCredenciales() async {
    /*
    setState(() {
      _isLoading = true;
    });
    */
    try {
      final response = await dioClient.dio.post(
          '/api/credentials/get-all-by-institution',
          data: {'institutionId': institutionId, 'fullname': fullname});
      if (response.statusCode == 200) {
        /*
        setState(() {
          credenciales =
              List<Map<String, dynamic>>.from(response.data['data']['content']);
          _isLoading = false;
          _notData = false;
        });
        */
        /*
        if (credenciales.isEmpty) {
          setState(() {
            _isLoading = false;
            _notData = true;
          });
        }
        */
      } else {
        setState(() {
          _isLoading = false;
          _notData = true;
        });
      }
    } catch (e) {
      /*
      setState(() {
        _isLoading = false;
        _notData = true;
      });
      */
      print(e);
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
      body: RefreshIndicator(
        onRefresh: getCredenciales,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Credenciales',
                style: TextStyle(
                  fontFamily: 'RubikOne',
                  fontSize: 37,
                  height: 1.2,
                ),
                textAlign:
                    TextAlign.center, // Asegura que el texto esté centrado
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      logo ?? '',
                      width: 125,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 60.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 150,
                      child: Text(
                        name ?? 'Nombre de la institución',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              _isLoading
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
                                  "No se encontraron credenciales",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Número de columnas
                              crossAxisSpacing:
                                  10.0, // Espacio horizontal entre tarjetas
                              mainAxisSpacing:
                                  10.0, // Espacio vertical entre tarjetas
                              childAspectRatio:
                                  2, // Relación ancho-alto de las tarjetas
                            ),
                            itemCount:
                                credenciales.length, // Número total de tarjetas
                            itemBuilder: (context, index) {
                              final credential = credenciales[
                                  index]; // Obtener cada credencial
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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CredentialDetail(
                                            credentialId:
                                                credential['credentialId'],
                                            userPhoto: credential['userPhoto'],
                                            fullname: credential['fullname'],
                                            expirationDate:
                                                credential['expirationDate'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage: NetworkImage(
                                              credential['userPhoto']),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                credential['fullname'],
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                DateFormat('dd/MM/yyyy').format(
                                                    credential[
                                                        'expirationDate']),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                ),
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UploadDocument()));
        },
        backgroundColor: Colors.black,
        child: const IconTheme(
          data: IconThemeData(
            color: Colors.white,
          ),
          child: Icon(Icons.document_scanner_outlined),
        ),
      ),
    );
  }
}
