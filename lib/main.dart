import 'package:flutter/material.dart';
import 'package:sigede_flutter/screens/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/screens/LoginScreen.dart';
import 'package:sigede_flutter/screens/RecoverPasswordScreen.dart';
import 'package:sigede_flutter/screens/admin/admin_registration_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=> const Loginscreen(),
        '/landing':(context)=> const Administratormanagementscreen(),
        '/recoverPassword':(context)=> const Recoverpasswordscreen(),
        '/admin-registration':(context)=> const AdminRegistrationScreen(),
      },
    );
  }
}
