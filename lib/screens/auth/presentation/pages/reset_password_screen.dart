import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  final int? userId;
  const ResetPasswordScreen({super.key, this.userId});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late int? userId;
  @override
  void initState() {
    super.initState();
    // Asignar el userId recibido
    userId = widget.userId;
  }

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isObscure = true;
  bool _isObcureCP = true;
  bool _isloading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValidPassword = true;
  bool _isValidConfirmPassword = true;
  // Función para validar la confirmación de la contraseña
  String? confirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      setState(() {
        _isValidConfirmPassword = false;
      });
      return 'Por favor, confirme su contraseña';
    } else if (_passwordController.text != confirmPassword) {
      setState(() {
        _isValidConfirmPassword = false;
      });
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _isValidPassword = false;
      });
      return 'Ingrese una contraseña';
    } else if (value.length < 8) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña debe tener al menos 8 caracteres';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña debe contener al menos una letra mayúscula';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña debe contener al menos una letra minúscula';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña debe contener al menos un número';
    } else if (value.contains(" ")) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña no debe contener espacios';
    } else if (!RegExp(r'^[a-zA-Z0-9\s]*$').hasMatch(value)) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña no debe contener caracteres especiales';
    }
    setState(() {
      _isValidPassword = true;
    });
    return null;
  }
  


  Future<void> _changePassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });
      // Llamar a la función de cambio de contraseña
      // Cambiar el estado de _isloading a false
      setState(() {
        _isloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Restablecer contraseña',
                  style: GoogleFonts.rubikMonoOne(
                      textStyle: const TextStyle(
                    fontSize: 30,
                  )),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Tu nueva contraseña debe ser diferente a contraseñas anteriores',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.grey)),
                ),
                const SizedBox(
                  height: 36.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        obscureText: _isObscure,
                        validator: validatePassword,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          labelStyle: TextStyle(
                            color: _isValidPassword
                                ? Colors.grey // Si la validación es exitosa
                                : Colors.red, // Si la validación falla
                          ),
                          
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      TextFormField(
                        obscureText: _isObscure,
                        validator: confirmPassword,
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirmar contraseña',
                          labelStyle: TextStyle(
                            color: _isValidConfirmPassword
                                ? Colors.grey // Si la validación es exitosa
                                : Colors.red, // Si la validación falla
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              color: _isValidConfirmPassword
                                  ? Colors.grey // Si la validación es exitosa
                                  : Colors.red, // Si la validación falla
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Expanded(child: Column()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isloading ? null : _changePassword,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: _isloading
                          ? const LoadingWidget() // Mostrar loading si está cargando
                          : Text(
                              'Restablecer',
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
        ));
  }
}
