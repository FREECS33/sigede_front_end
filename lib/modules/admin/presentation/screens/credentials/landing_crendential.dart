import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/credential_entity.dart';
import 'package:sigede_flutter/modules/admin/presentation/widgets/custom_list_credential.dart';

class LandingCrendential extends StatefulWidget {
const LandingCrendential({ super.key });

  @override
  State<LandingCrendential> createState() => _LandingCrendentialState();
}

class _LandingCrendentialState extends State<LandingCrendential> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _notData = false;
  List<CredentialEntity> credentials = [];

  @override
  void initState() {
    super.initState();
    // Inicializa el estado del switch con la información recibida.
    getAllCredentials();
  }

  Future<void> _loadCredentials(String search) async {
    setState(() {
      _isLoading = true;
      _notData = false;
    });
    try {
      // Call to the API
    } catch (e) {
      setState(() {
        _notData = true;
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
      // Call to the API
      setState(() {
        _notData = true;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _notData = true;
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,     
        toolbarHeight: 30,   
      ),
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
                      'https://www.utez.edu.mx/wp-content/uploads/2024/08/LOGO_UTEZ-2016.png',
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
                        'Nombre de la institución',
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
                        hintText: 'Buscar credencial', // Texto placeholder
                        hintStyle: const TextStyle(
                            color: Colors.grey), // Color del placeholder
                        border: InputBorder.none, // Quita el borde predeterminado
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.grey, // Icono de búsqueda
                          ),
                          onPressed: () {
                            // Llamar a la función al presionar el icono
                            _loadCredentials(_searchController.text);
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
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
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: credentials.length,
                            itemBuilder: (context, index) {
                              return CustomListCredential(                                
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