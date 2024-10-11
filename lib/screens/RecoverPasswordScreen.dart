import 'package:flutter/material.dart';

class Recoverpasswordscreen extends StatefulWidget {
  const Recoverpasswordscreen({super.key});

  @override
  State<Recoverpasswordscreen> createState() => _RecoverpasswordscreenState();
}

class _RecoverpasswordscreenState extends State<Recoverpasswordscreen> {
  @override
  Widget build(BuildContext context) {
     return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Pantalla de Recuperar contraseña'),
              
            ],
          ),
        ),
      ),
    );
  }
}