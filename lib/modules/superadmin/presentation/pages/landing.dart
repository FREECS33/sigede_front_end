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
  final GetIt getIt = GetIt.instance;
  Future<void> getInstitutions() async {
    try {
      final institutionsUseCase = getIt<Institutions>();
      final response = await institutionsUseCase.call();

      setState(() {
        institutions = response.data; // Asigna los datos obtenidos
        _isLoading = false; // Quita el indicador de carga
      });
    } catch (error) {
      // Manejo de errores
      setState(() {
        _isLoading = false;
      });
      print('Error al obtener instituciones: $error');
    }
  }
/*
  final List<Map<String, String>> institutions = [
    {
      'logoUrl':
          'https://www.utez.edu.mx/wp-content/uploads/2024/08/LOGO_UTEZ-2016.png',
      'institutionName': 'Universidad Tecnológica Emiliano Zapata',
      'role': 'Administrador',
      'location': 'San Marcos de la O Fonseca',
    },
    {
      'logoUrl':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/Example_logo.svg/512px-Example_logo.svg.png',
      'institutionName': 'Universidad Nacional Autónoma de México',
      'role': 'Coordinador',
      'location': 'Ciudad Universitaria, CDMX',
    },
  ];
*/
  @override
  void initState() {
    super.initState();
    getInstitutions(); // Realiza la petición cuando el widget se construye
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Asegura que ambos textos comiencen en el mismo punto horizontal
          children: [
            Text(
              'Clientes',
              style: GoogleFonts.rubikMonoOne(
                textStyle: const TextStyle(
                  fontSize: 30,
                  height: 1.2, // Ajusta la altura de línea
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
            Expanded(
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
