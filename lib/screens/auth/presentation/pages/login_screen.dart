import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/screens/auth/data/models/login_model.dart';
import 'package:sigede_flutter/screens/auth/domain/entities/login_entity.dart';
import 'package:sigede_flutter/screens/auth/domain/use_cases/login.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class Loginscreen extends StatefulWidget {
  final LoginEntity? entity;
  const Loginscreen({super.key, this.entity});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isObscure = true;
  bool _isValidPassword = true;
  bool _isValidUserEmail = true;
  bool _isloading = false;
  final GetIt getIt = GetIt.instance;
  Future<void> _loginSubmit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });

      try {
        // Recuperar valores de los controladores
        final String email = _emailcontroller.text.trim();
        final String password = _passwordcontroller.text.trim();

        // Crear entidad para el caso de uso
        final LoginEntity loginEntity =
            LoginEntity(userEmail: email, password: password);

        final LoginModel loginModel = LoginModel(
          userEmail: loginEntity.userEmail,
          password: loginEntity.password,
        );
        // Inyectar el caso de uso
        final loginUseCase = getIt<Login>();

        // Llamar al caso de uso
        final result = await loginUseCase.call(loginModel);

        // Manejo del resultado
        if (result != null) {
          // Ajusta según el contenido de LoginEntity
          Navigator.pushReplacementNamed(context, '/navigation');
        } else {
          throw Exception("Error: Token no recibido");
        }
      } catch (error) {
        // Mostrar error al usuario
        print(error);
      } finally {
        setState(() {
          _isloading = false;
        });
      }
    }
  }

  String? validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      setState(() {
        _isValidUserEmail = false;
      });
      return 'Por favor, ingrese su correo electrónico';
    } else if (!emailRegExp.hasMatch(value)) {
      setState(() {
        _isValidUserEmail = false;
      });
      return 'Por favor, ingrese un correo electrónico válido';
    }
    setState(() {
      _isValidUserEmail = true;
    });
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _isValidPassword = false;
      });
      return 'Ingrese una contraseña';
    }
    setState(() {
      _isValidPassword = true;
    });
    return null; // Si es válido, no retorna nada.
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Bienvenido',
                      style: GoogleFonts.rubikMonoOne(
                          textStyle: const TextStyle(fontSize: 28))),
                  const SizedBox(height: 16),
                  Image.asset(
                    'Logo_sigede.png',
                    height: 150,
                    width: 200,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    'SIGEDE',
                    style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 8.0,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      labelStyle: TextStyle(
                        color: _isValidUserEmail
                            ? Colors.grey // Si la validación es exitosa
                            : Colors.red, // Si la validación falla
                      ),
                      suffixIcon: Icon(
                        Icons.email_outlined,
                        color: _isValidUserEmail
                            ? Colors.grey // Si la validación es exitosa
                            : Colors.red,
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    validator: validatePassword,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(
                        color: _isValidPassword
                            ? Colors.grey // Si la validación es exitosa
                            : Colors.red, // Si la validación falla
                      ),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          color: _isValidPassword
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
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _loginSubmit,
                      style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: _isloading
                          ? const LoadingWidget() // Mostrar loading si está cargando
                          : const Text(
                              'Entrar',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/recoverPassword');
                      },
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Olvide la contraseña',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
