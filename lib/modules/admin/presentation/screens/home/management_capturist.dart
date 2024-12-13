import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista_model.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/institution_info_entity.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_by_name_institution.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturistas.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_one_institution.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/register_capturist.dart';
import 'package:sigede_flutter/modules/admin/presentation/widgets/custom_list_capturist.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';

class CapturistasScreen extends StatefulWidget {
  const CapturistasScreen({super.key});

  @override
  State<CapturistasScreen> createState() => _CapturistasScreenState();
}

class _CapturistasScreenState extends State<CapturistasScreen> {
  final GetIt getIt = GetIt.instance;
  bool _isLoading = false;
  bool _notData = false;
  List<CapturistaEntity> capturistas = [];
  InstitutionInfoEntity? institution;
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Future<void> _getInstitution() async {
    setState(() {
      _isLoading = true;      
    });
    try {
      final institutionId = await TokenService.getInstituionId();
      if (institutionId == null) {
        throw Exception("Institution ID no encontrado.");
      }
      final getInstitution = getIt<GetOneInstitution>();
      final result = await getInstitution.call(institutionId);
      setState(() {
        institution = result;
      });
      if(institution != null){
        await TokenService.saveLogo(institution!.logo);
        await TokenService.saveInstitutionName(institution!.name);
      }
    } catch (e) {
      setState(() {
        _isLoading = true;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  Future<void> _getAllCapturistas() async {
    setState(() {
      _isLoading = true;
      _notData = false;
    });
    try {
      final institutionId = await TokenService.getInstituionId();
      if (institutionId == null) {
        throw Exception("Institution ID no encontrado.");
      }
      final getCapturistasUseCase = getIt<GetCapturistas>();
      final result = await getCapturistasUseCase.call(institutionId);

      setState(() {
        capturistas = result;
      });
    } catch (e) {
      setState(() {
        _notData = true;
      });
    } finally {
      setState(() {
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

  Future<void> _loadCapturers(String text) async {
    setState(() {
      _isLoading = true;
      _notData = false;
    });
    try {
      final institutionId = await TokenService.getInstituionId();
      final FilterCapturerModel capturersModel = FilterCapturerModel(
          name: text,
          institutionId: institutionId??0,
          page: 0,
          size: 200);

      final capturersByInstitution = getIt<GetByNameInstitution>();
      final result = await capturersByInstitution.call(capturersModel);
      if(result.isEmpty){
        setState(() {
          _notData = true;
          _isLoading = false;
        });
      }
      setState(() {
        capturistas = result;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _notData = false;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getInstitution();
    _getAllCapturistas();    
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
        onRefresh: _getAllCapturistas,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Capturistas',
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
                      institution?.logo ?? '',
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
                        institution?.name??'',
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
                      validator: validateSearch,
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Buscar capturista', // Texto placeholder
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
                            _loadCapturers(_searchController.text);
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
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
                                  "No se encontraron capturistas",
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
                            itemCount: capturistas.length,
                            itemBuilder: (context, index) {
                              return CustomListCapturist(
                                capturista: capturistas[index],
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterCapturist(
                        
                      )));
        },
        backgroundColor: Colors.black,
        child: const IconTheme(
          data: IconThemeData(
            color: Colors.white,
          ),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
