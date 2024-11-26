import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class CodeConfirmation extends StatefulWidget {
  const CodeConfirmation({super.key});

  @override
  State<CodeConfirmation> createState() => _CodeConfirmationState();
}

class _CodeConfirmationState extends State<CodeConfirmation> {
  final TextEditingController _codeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isloading = false;

  String? _code;
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

  Future<void> _codeConfirmation() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isloading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isloading = false;
      });
    }
  }

  Future<void> _checkClipboardForCode() async {
    ClipboardData? clipboardData = await Clipboard.getData('text/plain');
    if (clipboardData != null && clipboardData.text != null) {
      String pastedCode = clipboardData.text!;
      if (pastedCode.length == 6 && _isNumeric(pastedCode)) {
        setState(() {
          _codeController.text = pastedCode;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Código pegado automáticamente")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No hay un código válido en el portapapeles")),
        );
      }
    }
  }

  
  bool _isNumeric(String str) {
    return RegExp(r'^[0-9]+$').hasMatch(str);
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
                  'Verificar código',
                  style: GoogleFonts.rubikMonoOne(
                      textStyle: const TextStyle(
                    fontSize: 30,
                  )),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Text(
                  'Para restablecer tu contraseña, por favor ingresa el código de verificación que hemos enviado a tu correo electrónico',
                  style: GoogleFonts.roboto(
                      textStyle: const TextStyle(color: Colors.grey)),
                ),
                const SizedBox(
                  height: 36.0,
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        PinCodeTextField(
                            appContext: context,
                            length: 6, 
                            controller: _codeController,
                            onChanged: (value) {
                              setState(() {
                                _code = value;
                              });
                            },
                            onTap: () async {
                              await _checkClipboardForCode();
                            },
                            validator: validateCode,
                            textStyle: const TextStyle(color: Colors.black),
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(8),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeColor: Colors.black,
                              selectedColor: Colors.red,
                              inactiveColor: Colors.red,
                            ),
                            keyboardType: TextInputType.number,
                            enablePinAutofill: true),
                      ],
                    ),
                  ),
                ),
                const Expanded(child: Column()),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isloading ? null : _codeConfirmation,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: _isloading
                          ? const LoadingWidget() // Mostrar loading si está cargando
                          : Text(
                              'Enviar',
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
