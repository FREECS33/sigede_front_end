import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/post_capturista.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class RegisterCapturist extends StatefulWidget {
  const RegisterCapturist({super.key});

  @override
  State<RegisterCapturist> createState() => _RegisterCapturistState();
}

class _RegisterCapturistState extends State<RegisterCapturist> {
  String? logo;
  String? name;
  bool _isLoading = false;
  bool _isValidAdminEmail = true;
  bool _isValidAdminName = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late PostCapturista postCapturista;
  bool isLoading=false;

  @override
  void initState() {
    super.initState();
    postCapturista = locator<PostCapturista>();
    Future.delayed(Duration.zero, () async {
      await loadData();
    });
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      logo = await TokenService.getLogo();
      name = await TokenService.getInstitutionName();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _registerCapturista()async{
    try {
      setState(() {
        isLoading=true;
      });
      // OBTENER EL ID DE LA INSTITUCION MEDIANTE EL SHARE PREFERENCES PARA ENVIARLO A postCapturista.call()
      final response = await postCapturista.call(name: _nameController.text, email: _emailController.text, fkInstitution: 1);
      print('LLEGO _registerCapturista: $response');
      setState(() {
        isLoading=false;
      });
      await showSuccessDialog(context: context, message: "Capturista registrado correctamente");
      Navigator.pushReplacementNamed(context, '/navigation'); 
    } catch (e) {
      print('Error en _registerCapturista: $e');
    }
  }

  String? validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      setState(() {
        _isValidAdminEmail = false;
      });
      return 'Por favor, ingrese un correo electrónico';
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

  String? validateName(String? value) {
    final RegExp nameRegExp = RegExp(r"^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$");

    if (value == null || value.trim().isEmpty) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'Por favor, ingrese un nombre';
    } else if (value.trim().length < 3) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'El nombre debe tener al menos 3 caracteres';
    } else if (!nameRegExp.hasMatch(value)) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'El nombre solo debe contener letras y espacios';
    }
    setState(() {
        _isValidAdminName = true;
      });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        backgroundColor: Colors.white,
        toolbarHeight: 30.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(        
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [          
              const Text(
                'Registrar Capturista',
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
                        name ?? 'Nombre del administrador',
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
                          validator: validateName,
                          controller: _nameController,
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
                          validator: validateEmail,
                          controller: _emailController,
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
                padding: const EdgeInsets.only(bottom: 150.0),
                child: SizedBox(
                  width: 300,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _registerCapturista,
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
        ),
      ),
    );
  }
}
