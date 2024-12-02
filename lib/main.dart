import 'package:flutter/material.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/modules/superadmin/navigation/navigation.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/landing.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/widgets/custom_list_institution.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/edit_capturist.dart';
import 'package:sigede_flutter/navigation/navigation_admin.dart';
import 'package:sigede_flutter/modules/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/login_screen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/code_confirmation_screen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/recovery_password_screen.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/reset_password_screen.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/admin_registration_screen.dart';
import 'package:sigede_flutter/modules/public/preview_qr.dart';


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
        '/':(context)=> const Navigation(),
        '/landing':(context)=> const Administratormanagementscreen(),
        '/recoverPassword':(context)=> const Recoverpasswordscreen(),
        '/codeConfirmation':(context)=> const CodeConfirmationScreen(),
        '/resetPassword':(context)=> const ResetPasswordScreen(),
        '/admin-registration':(context)=> const AdminRegistrationScreen(),
        '/preview-qr':(context)=>const PreviewQR(),
        '/navigation':(context)=>const NavigationAdmin(),
        '/landing-super':(context)=> Landing(),
        //'/navigation-super':(context)=>const Navigation(),
        '/editCapturist':(context)=>const EditCapturist()
      },
    );
  }
}
