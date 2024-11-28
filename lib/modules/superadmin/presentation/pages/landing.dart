import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/institutions.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/widgets/custom_list_institution.dart';

class Landing extends StatefulWidget {
  Landing({super.key});

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  List<InstitutionsEntity> institutions = [];
  bool _isLoading = true;
  bool _notData = false;
  final GetIt getIt = GetIt.instance;
  Future<void> getInstitutions() async {
    try {
      final institutionsUseCase = getIt<Institutions>();
      final response = await institutionsUseCase.call();

      setState(() {
        institutions = response.data;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _notData = true;
      });
      print('Error al obtener instituciones: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getInstitutions();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Clientes',
              style: GoogleFonts.rubikMonoOne(
                textStyle: const TextStyle(
                  fontSize: 30,
                  height: 1.2,
                ),
              ),
            ),
            Text(
              'Todos los clientes',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 16, // Define explícitamente el tamaño
                  color: Colors.grey,
                  height: 1.2, // Mantén la misma altura de línea
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Center(
              child: Container(
                width: 300, // Ajusta el ancho según lo necesites
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFF6F5F5), // Color de fondo del TextField
                  borderRadius: BorderRadius.circular(25), // Bordes redondeados
                  border: Border.all(
                    color: const Color(0xFF917D62), // Color del borde
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(0.2), // Color de la sombra
                      spreadRadius: 1, // Cuánto se expande la sombra
                      blurRadius: 8, // Cuán difusa es la sombra
                      offset: const Offset(0, 4), // Sombra hacia abajo
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      hintText: 'Buscar cliente', // Texto placeholder
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color del placeholder
                      border: InputBorder.none, // Quita el borde predeterminado
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey, // Icono de búsqueda
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            _notData
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
                                fontWeight: FontWeight.bold, color: Colors.grey),
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
    );
  }
}
