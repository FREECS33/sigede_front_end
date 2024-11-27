import 'package:flutter/material.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/navigation/navigation_admin.dart';
import 'package:sigede_flutter/screens/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/login_screen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/code_confirmation_screen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/recovery_password_screen.dart';
import 'package:sigede_flutter/screens/auth/presentation/pages/reset_password_screen.dart';
import 'package:sigede_flutter/screens/admin/admin_registration_screen.dart';
import 'package:sigede_flutter/screens/public/preview_qr.dart';


void main() {
  setupLocator();
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
        '/codeConfirmation':(context)=> const CodeConfirmationScreen(),
        '/resetPassword':(context)=> const ResetPasswordScreen(),
        '/admin-registration':(context)=> const AdminRegistrationScreen(),
        '/preview-qr':(context)=>const PreviewQR(),
        '/navigation':(context)=>const NavigationAdmin()
      },
    );
  }
}
