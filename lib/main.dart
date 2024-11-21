import 'package:flutter/material.dart';
import 'package:sigede_flutter/navigation/navigation_admin.dart';
import 'package:sigede_flutter/screens/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/LoginScreen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/CodeConfirmation.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/RecoverPasswordScreen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/ResetPasswordScreen.dart';
import 'package:sigede_flutter/screens/admin/admin_registration_screen.dart';
import 'package:sigede_flutter/screens/public/preview_qr.dart';


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
        '/admin-registration':(context)=> const AdminRegistrationScreen(),
        '/preview-qr':(context)=>const PreviewQR(),
        '/navigation':(context)=>const NavigationAdmin()
      },
    );
  }
}
