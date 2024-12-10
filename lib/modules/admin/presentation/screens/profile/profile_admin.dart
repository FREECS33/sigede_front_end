import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/login_screen.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';

class ProfileAdmin extends StatefulWidget {
const ProfileAdmin({ super.key });

  @override
  State<ProfileAdmin> createState() => _ProfileAdminState();
}

class _ProfileAdminState extends State<ProfileAdmin> {
  bool _isloading = false;

  Future<void> _closeSession() async {
    setState(() {
      _isloading = true;
    });
    TokenService.clearToken();
    TokenService.clearInstitutionId();
    TokenService.clearUserEmail();
    TokenService.clearInstitutionName();
    TokenService.clearLogo();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Loginscreen()),
      (route) => false,
    );

    setState(() {
      _isloading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
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
                'assets/Logo_sigede.png',
                height: 150,
                width: 200,
              ),
              const SizedBox(height: 24),
              const Text(
                'Administrador',
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