import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/home/management_capturist.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/home/update_capturist.dart';

class HomeCapturer extends StatefulWidget {
  const HomeCapturer({ Key? key }) : super(key: key);

  @override
  _HomeCapturerState createState() => _HomeCapturerState();
}

class _HomeCapturerState extends State<HomeCapturer> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        
        if (settings.name == '/edit-cpturist') {
          return MaterialPageRoute(builder: (context) => const UpdateCapturist());
        }
        
        
        return MaterialPageRoute(builder: (context) => const CapturistasScreen());
      },
    );
  }
}