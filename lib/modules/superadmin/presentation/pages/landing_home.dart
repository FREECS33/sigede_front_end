import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/institution_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/institution_cases/institution_use_case.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/widgets/custom_list_institution.dart';

class LandingHome extends StatefulWidget {
  const LandingHome({super.key});

  @override
  _LandingHomeState createState() => _LandingHomeState();
}

class _LandingHomeState extends State<LandingHome> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<InstitutionEntity> institutions = [];

  bool _isLoading = true;
  bool _notData = false;
  final GetIt getIt = GetIt.instance;
  Future<void> getInstitutions() async {
    try {
      final institutionsUseCase = getIt<GetAllInstitutions>();
      final response = await institutionsUseCase.call();

      setState(() {
        institutions = response;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _notData = true;
      });
    }
  }

  // Función para consumir el endpoint
  Future<void> _loadInstitutions(String text) async {
    setState(() {
      _isLoading = true;
      _notData = false;
    });
    try {
      final institutionByName = getIt<GetInstitutionByName>();
      final response = await institutionByName.call(PageModel(name: text, page: 0, size: 100));
      if(response.isEmpty){
        setState(() {
          _notData = true;
          _isLoading = false;
        });
      }
      setState(() {
        institutions = response;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _notData = true;
        _isLoading = false;
      });
    }
  }

  String? validateSearch(String? value) {
    if (value == null || value.isEmpty) {
      return 'El campo no puede estar vacío';
    }
    // solo se permiten letras y espacios y numeros
    final RegExp nameExp = RegExp(r'^[A-Za-z0-9 ]+$');
    if (!nameExp.hasMatch(value)) {
      return 'Por favor, solo ingrese caracteres válidos';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    getInstitutions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65), // Altura deseada
        child: Container(
          color: Colors.transparent, // Fondo transparente
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0,top: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Clientes',
                    style: TextStyle(
                      fontFamily: 'RubikOne',
                      fontSize: 39,
                      height: 1.0,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Todos los clientes',
                    style: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        height: 1.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: getInstitutions,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Center(
                  child: Container(
                    width: 500, // Ajusta el ancho según lo necesites
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: const Color(
                          0xFFF6F5F5), // Color de fondo del TextField
                      borderRadius:
                          BorderRadius.circular(25), // Bordes redondeados
                      border: Border.all(
                        color: const Color(0xFF917D62), // Color del borde
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.2), // Color de la sombra
                          spreadRadius: 1, // Cuánto se expande la sombra
                          blurRadius: 8, // Cuán difusa es la sombra
                          offset: const Offset(0, 4), // Sombra hacia abajo
                        ),
                      ],
                    ),
                    child: TextFormField(
                      validator: validateSearch,
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar cliente', // Texto placeholder
                        hintStyle: const TextStyle(
                            color: Colors.grey), // Color del placeholder
                        border:
                            InputBorder.none, // Quita el borde predeterminado
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.search,
                            color: Colors.grey, // Icono de búsqueda
                          ),
                          onPressed: () {
                            // Llamar a la función al presionar el icono
                            _loadInstitutions(_searchController.text);
                          },
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 12),
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
                                  "Clientes no encontrados",
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
                            itemCount: institutions.length,
                            itemBuilder: (context, index) {
                              return CustomListInstitution(
                                institutions: institutions[index],
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
