import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admin_entity.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class EditAdmin extends StatefulWidget {
  final AdminEntity? admin;
  final String? logo;
  final String? name;
  const EditAdmin({super.key, this.admin, this.logo, this.name});

  @override
  State<EditAdmin> createState() => _EditAdminState();
}

class _EditAdminState extends State<EditAdmin> {
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameAdminController = TextEditingController();

  bool _isValidAdminName = true;  

  bool light = true;
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  
  String? validateNameAdmin(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'Campo obligatorio';
    }
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegExp.hasMatch(value)) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'Solo se permiten letras';
    }
    if (value.trim() != value) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'No debe contener espacios al inicio o al final';
    }
    if (value.length > 50) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'No debe superar los 50 caracteres';
    }
    setState(() {
      _isValidAdminName = true;
    });
  }

  Future<void> _editAdmin() async {
    setState(() {
      _isLoading = true;
    });   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 35),
          const Text(
            'Editar Administrador',
            style: TextStyle(
              fontFamily: 'RubikOne',
              fontSize: 39,
              height: 1.2,
            ),
            textAlign: TextAlign.center, // Asegura que el texto esté centrado
          ),
          SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  widget.logo ?? '',
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
                    widget.name ?? 'Nombre de la institución',
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
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      validator: validateNameAdmin,
                      controller: _nameAdminController,
                      decoration: InputDecoration(
                        labelText: 'Nombre administrador',
                        labelStyle: TextStyle(
                          color: _isValidAdminName
                              ? Colors.grey // Si la validación es exitosa
                              : Colors.red, // Si la validación falla
                        ),
                        suffixIcon: Icon(
                          Icons.admin_panel_settings_outlined,
                          color: _isValidAdminName ? Colors.grey : Colors.red,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(children: [
                      const Text(
                        'Cambiar estado del administrador',
                        style: TextStyle(
                          fontFamily: 'RubikOne',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Switch(
                        inactiveThumbColor: Colors.red,
                        inactiveTrackColor: Colors.red.withOpacity(0.5),
                        activeTrackColor: Colors.green.withOpacity(0.5),
                        thumbIcon: thumbIcon,
                        value: light,
                        activeColor: Colors.green,
                        onChanged: (bool value) {
                          // This is called when the user toggles the switch.
                          setState(() {
                            light = value;
                          });
                        },
                      )
                    ])
                  ]),
            ),
          ),
          const Expanded(child: Column()),
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: SizedBox(
              width: 300,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _editAdmin,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: _isLoading
                    ? const LoadingWidget() // Mostrar loading si está cargando
                    : Text(
                        'Guardar',
                        style: GoogleFonts.roboto(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
