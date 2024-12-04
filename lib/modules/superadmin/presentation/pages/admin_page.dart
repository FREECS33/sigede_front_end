import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admin_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institutions_entity.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/add_admin.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/widgets/custom_list_admin.dart';

class AdminPage extends StatefulWidget {
  final InstitutionsEntity? institutions;
  const AdminPage({super.key, this.institutions});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  late InstitutionsEntity? data;

  @override
  void initState() {
    super.initState();
    data = widget.institutions;
  }

  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = true;
  bool _notData = false;
  List<AdminEntity> admins = [
    AdminEntity(name: 'Admin 1', email: 'admin1@gmail.com'),
    AdminEntity(name: 'Admin 2', email: 'admin2@gmail.com'),
    AdminEntity(name: 'Admin 3', email: 'admin3@gmail.com'),
  ];

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

  Future<void> _loadAdmins(String text) async {
    /*
    setState(() {
      _isLoading = true;
      _notData = false;
    });
    try {
      final adminByName = getIt<>();
      final response = await adminByName.call(
          text, 0, 10); 
      setState(() {
        admins = response.content;
        _isLoading = false;
      });
      print("si sali ");
    } catch (e) {
      setState(() {
        _notData = true;
        _isLoading = false;
      });
    }
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Administradores',
            style: TextStyle(
              fontFamily: 'RubikOne',
              fontSize: 36,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    data?.logo ?? '',
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
                      data?.name ?? 'Nombre de la institución',
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
                      hintText: 'Buscar administrador', // Texto placeholder
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
                          _loadAdmins(_searchController.text);
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
                            "Adminstradores no encontrados",
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
                      itemCount: admins.length,
                      itemBuilder: (context, index) {
                        return CustomListAdmin(
                          admins: admins[index],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder: (context) => AddAdmin(logo: data?.logo, name: data?.name,)));          
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
