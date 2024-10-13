import 'package:flutter/material.dart';
import 'package:sigede_flutter/screens/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/screens/auth/LoginScreen.dart';
import 'package:sigede_flutter/screens/auth/recoverPassword/CodeConfirmation.dart';
import 'package:sigede_flutter/screens/auth/recoverPassword/RecoverPasswordScreen.dart';
import 'package:sigede_flutter/screens/auth/recoverPassword/ResetPasswordScreen.dart';

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
        '/codeConfirmation':(context)=> const CodeConfirmation(),
        '/resetPassword':(context)=> const ResetPasswordScreen(),
      },
    );
  }
}
