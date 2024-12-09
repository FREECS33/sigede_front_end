import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/app_navigator.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/modules/auth/jwt/jwt_decoder.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/login_screen.dart';
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
            return const Loginscreen(); 
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
