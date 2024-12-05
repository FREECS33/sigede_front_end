import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool _isloading = false;

  Future<void> _closeSession() async {
    setState(() {
      _isloading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'SIGEDE',
                style: TextStyle(
                    fontFamily: 'RubikOne',
                    fontSize: 34,
                    letterSpacing: 8.0,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 16),
              Image.asset(
                'Logo_sigede.png',
                height: 150,
                width: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                'Super Administrador',
                style: TextStyle(
                  fontFamily: 'RubikOne',
                  fontSize: 24,
                  letterSpacing: 8.0,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              const Expanded(
                child: Center(
                  child: Icon(
                    Icons.admin_panel_settings,
                    size: 50.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: SizedBox(
                  width: 300,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: _isloading ? null : _closeSession,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: _isloading
                        ? const LoadingWidget() // Mostrar loading si está cargando
                        : Text(
                            'Cerrar sesión',
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
        ));
  }
}
