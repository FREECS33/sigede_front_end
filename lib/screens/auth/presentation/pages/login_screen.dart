import 'dart:math';

import 'package:dio/dio.dart';
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

        final LoginModel loginModel = LoginModel(
          userEmail: email,
          password: password,
        );
        // Inyectar el caso de uso
        final loginUseCase = getIt<Login>();

        // Llamar al caso de uso
        final result = await loginUseCase.call(loginModel);

        // Manejo del resultado
        if (result != null) {
          Navigator.pushReplacementNamed(context, '/navigation');
        } else {
          throw Exception("Error: Token no recibido");
        }
      } catch (error) {
        String errorMessage = "Unknown error occurred";

        if (error is DioException) {
          errorMessage = error.response?.data?['message'] ?? "Unknown error";
        } else {
          errorMessage = "An unexpected error occurred"; // Mensaje genérico
        }

        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
              icon: Icon(
                Icons.error,
                color: Colors.red[600],
              ),
              title: Text(
                "Error",
                style: TextStyle(color: Colors.red[600]),
              ),
              content: Text(
                errorMessage,
                textAlign: TextAlign.center,
              )),
        );

        Future.delayed(const Duration(seconds: 1), () {
          _formKey.currentState!.reset();
          _emailcontroller.clear();
          _passwordcontroller.clear();
          Navigator.of(context, rootNavigator: true).pop();
        });
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
    } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña debe contener al menos un carácter especial';
    } else if (value.contains(" ")) {
      setState(() {
        _isValidPassword = false;
      });
      return 'La contraseña no debe contener espacios';
    }
    setState(() {
      _isValidPassword = true;
    });
    return null;
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
                      onPressed: _isloading ? null : _loginSubmit,
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
