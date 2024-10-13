import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CodeConfirmation extends StatefulWidget {
  const CodeConfirmation({super.key});

  @override
  State<CodeConfirmation> createState() => _CodeConfirmationState();
}

String? validateCode(String? value) {
  if (value == null || value.isEmpty) {
    return 'Por favor, ingrese su código';
  }

  final int? code = int.tryParse(value);

  if (code == null || code <= 0) {
    return 'Por favor, ingrese un código válido';
  }

  return null;
}

class _CodeConfirmationState extends State<CodeConfirmation> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                      "Codigo de verificación",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      "Por favor, ingresa el código de verificación que hemos enviado a tu correo electrónico.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: "Ingresa tu Codigo de verificaion",
                        label: const Text("Codigo de verificaion"),
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
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 6,
                      validator: validateCode,
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
                            print("AQUI VA LA LOGICA DEL VALIDACION DE CODIGO");
                            Navigator.pushNamed(context, '/resetPassword');
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
                          "Verificar código",
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
