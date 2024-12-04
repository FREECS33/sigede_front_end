import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class AddAdmin extends StatefulWidget {
  final String? logo;
  final String? name;
  const AddAdmin({super.key, this.logo, this.name});

  @override
  State<AddAdmin> createState() => _AddAdminState();
}

class _AddAdminState extends State<AddAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameAdminController = TextEditingController();
  final TextEditingController _emailAdminController = TextEditingController();
  bool _isloading = false;
  bool _isValidAdminName = true;
  bool _isValidAdminEmail = true;
  String? validateEmailAdmin(String? value) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      setState(() {
        _isValidAdminEmail = false;
      });
      return 'Por favor, ingrese su correo electrónico';
    } else if (!emailRegExp.hasMatch(value)) {
      setState(() {
        _isValidAdminEmail = false;
      });
      return 'Por favor, ingrese un correo electrónico válido';
    }
    setState(() {
      _isValidAdminEmail = true;
    });
    return null;
  }

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

  Future<void> _registerAdmin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      // Lógica para registrar al administrador
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 35),
          const Text(
            'Registrar Administrador',
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
                    TextFormField(
                      validator: validateEmailAdmin,
                      controller: _emailAdminController,
                      decoration: InputDecoration(
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(
                          color: _isValidAdminEmail
                              ? Colors.grey // Si la validación es exitosa
                              : Colors.red, // Si la validación falla
                        ),
                        suffixIcon: Icon(
                          Icons.email_outlined,
                          color: _isValidAdminEmail ? Colors.grey : Colors.red,
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
                onPressed: _isloading ? null : _registerAdmin,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: _isloading
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
