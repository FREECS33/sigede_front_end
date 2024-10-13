import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isObcureP = true;
  bool _isObcureCP = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Función para validar la confirmación de la contraseña
  String? confirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Por favor, confirme su contraseña';
    } else if (_passwordController.text != confirmPassword) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su contraseña';
    }
    return null; // Si es válido, no devuelve ningún error
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Recuperacion de contraseña',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF47649D),
        centerTitle: true,
      ),
      body: Container(
        color: const Color(0xFFE4E4E4),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    const Text(
                      "Reestablecer contraseña",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Favor de ingresar tu nueva contraseña.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _isObcureP,
                      decoration: InputDecoration(
                          hintText: "Ingresa tu contraseña",
                          label: const Text("Contraseña"),
                          filled: true, // Activa el fondo
                          fillColor: Colors.white, // color de fondo
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            // Estilos cuando no está seleccionado
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObcureP = !_isObcureP;
                                });
                              },
                              icon: Icon(_isObcureP
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      keyboardType: TextInputType.emailAddress,
                      validator: validatePassword,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _isObcureCP,
                      decoration: InputDecoration(
                          hintText: "Ingresa nuevamente tu contraseña",
                          label: const Text("Confirmar contraseña"),
                          filled: true, // Activa el fondo
                          fillColor: Colors.white, // color de fondo
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            // Estilos cuando no está seleccionado
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObcureCP = !_isObcureCP;
                                });
                              },
                              icon: Icon(_isObcureCP
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      keyboardType: TextInputType.emailAddress,
                      validator: confirmPassword,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print("AQUI VA LA LOGICA DEL CAMBIO DE CONTRASEÑA");
                            Navigator.pushNamed(context, '/');
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF27AE60),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Enviar correo",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
