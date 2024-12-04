import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/add_admin.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/admin_page.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/landing_home.dart';

class Landing extends StatefulWidget {
  const Landing({ super.key });

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        
        if (settings.name == '/admin') {
          return MaterialPageRoute(builder: (context) => const AdminPage());
        }
        if (settings.name == '/post-admin') {
          return MaterialPageRoute(builder: (context) => const AddAdmin());
        }
        
        return MaterialPageRoute(builder: (context) => const AdminPage());
      },
    );
  }
}