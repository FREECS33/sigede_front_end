import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/app_navigator.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/register_capturist.dart';
import 'package:sigede_flutter/modules/auth/jwt/jwt_decoder.dart';
import 'package:sigede_flutter/modules/superadmin/navigation/navigation.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/landing.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/edit_capturist.dart';
import 'package:sigede_flutter/modules/admin/navigation/navigation_admin.dart';
import 'package:sigede_flutter/modules/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/login_screen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/code_confirmation_screen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/recovery_password_screen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/reset_password_screen.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/admin_registration_screen.dart';
import 'package:sigede_flutter/modules/public/preview_qr.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';

void main() async {
  setupLocator();
  await dotenv.load(fileName: ".env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<String?>(
        future: _determineStartRoute(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final role = snapshot.data;
          if (role == null) {
            return const PublicNavigator(); 
          }

          return AppNavigator(userRole: role);
        },
      ),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0, // Desactiva la sombra por completo
          shadowColor: Colors.transparent, // Elimina cualquier color de sombra
        ),
      
      ),
      
      debugShowCheckedModeBanner: false,
      //initialRoute: '/',
      routes: {
        '/': (context) => const Loginscreen(),
        '/landing': (context) => const Administratormanagementscreen(),
        '/recoverPassword': (context) => const Recoverpasswordscreen(),
        '/codeConfirmation': (context) => const CodeConfirmationScreen(),
        '/resetPassword': (context) => const ResetPasswordScreen(),
        '/admin-registration': (context) => const AdminRegistrationScreen(),
        '/preview-qr': (context) => const PreviewQR(),
        '/navigation':(ontext)=>const NavigationAdmin(),
        '/landing-super': (context) => const Landing(),
        '/navigation-super': (context) => const Navigation(),
        '/editCapturist': (context) => const EditCapturist(),
        '/registerCapturist': (context) => const RegisterCapturist(),
        '/login': (context) => const Loginscreen()
      },
    );
  }
  Future<String?> _determineStartRoute() async {
    final token = await TokenService.getToken();

    if (token != null && !JwtDecoder.isExpired(token)) {
      return JwtDecoder.getRoleFromToken(token);
    }

    return null;
  }
}
