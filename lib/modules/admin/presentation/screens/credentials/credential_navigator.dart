import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/credential_detail.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/landing_crendential.dart';

class CredentialNavigator extends StatefulWidget {
const CredentialNavigator({ super.key });

  @override
  State<CredentialNavigator> createState() => _CredentialNavigatorState();
}

class _CredentialNavigatorState extends State<CredentialNavigator> {
  @override
  Widget build(BuildContext context){
    return Navigator(
      onGenerateRoute: (settings) {
        
        if (settings.name == '/detail-credential') {
          return MaterialPageRoute(builder: (context) => const CredentialDetail());
        }                
        return MaterialPageRoute(builder: (context) => const LandingCrendential());
      },
    );
  }
}