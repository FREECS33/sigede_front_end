import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/admin/navigation/navigation_admin.dart';
import 'package:sigede_flutter/modules/auth/presentation/pages/login_screen.dart';
import 'package:sigede_flutter/modules/superadmin/navigation/navigation.dart';


class AppNavigator extends StatelessWidget {
  final String userRole;

  const AppNavigator({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    switch (userRole) {
      case 'SUPERADMIN':
        return const Navigation();
      case 'ADMIN':
        return  const NavigationAdmin();
      //case 'CAPTURISTA':
        //return  const CapturistNavigator();
      default:
        return const Loginscreen(); // Si el rol es inválido, vuelve al flujo público
    }
  }
  
}
