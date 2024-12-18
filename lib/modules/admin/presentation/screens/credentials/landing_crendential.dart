import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/credential_entity.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_all_credentials.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/edit_credentials.dart';
import 'package:sigede_flutter/modules/admin/presentation/widgets/custom_list_credential.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';

class LandingCrendential extends StatefulWidget {
  const LandingCrendential({super.key});

  @override
  State<LandingCrendential> createState() => _LandingCrendentialState();
}

class _LandingCrendentialState extends State<LandingCrendential> {
  String? logo;
  String? name;
  int? institutionId;
  int? userAccoutId;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _notData = false;
  List<ResponseCredentialInstitutionEntity> credentialList = [];
  final GetIt getIt = GetIt.instance;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await loadData();
      await getAllCredentials();
    });
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      logo = await TokenService.getLogo();
      name = await TokenService.getInstitutionName();
      institutionId = await TokenService.getInstituionId();
      userAccoutId = await TokenService.getUserId();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> getAllCredentials() async {
    setState(() {
      _isLoading = true;
      _notData = false;
    });
    try {
      final credentials = await getIt<GetAllCredentials>();
      final response = await credentials.call(userAccoutId ?? 0);
      if (response.isNotEmpty) {
        setState(() {
          _notData = false;
          _isLoading = false;
          credentialList = response;
        });
      } else {
        setState(() {
          _notData = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _notData = true;
        _isLoading = false;
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
      body: RefreshIndicator(
        onRefresh: getAllCredentials,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Credenciales',
                style: TextStyle(
                  fontFamily: 'RubikOne',
                  fontSize: 37,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      logo ?? '',
                      width: 80,
                      height: 80,
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
                        name ?? '',
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
              Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    width: 500,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F5F5),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: const Color(0xFF917D62),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar credencial',
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            // Agrega funcionalidad de búsqueda si es necesario
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              _isLoading
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.black,
                        ),
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
                                  "Credenciales no encontradas",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: credentialList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => EditCredentialScreen(
        credentialId: credentialList[index].credentialId,
      ),
    ),
  );
},
  child: CustomListCredential(
    credential: credentialList[index],
  ),
);

                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
