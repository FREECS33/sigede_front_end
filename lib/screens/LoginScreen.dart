import 'package:flutter/material.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Pantalla de incio de sesion'),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recoverPassword');
                },
                child: const Text('Recuperar contraseña', style: TextStyle(color: Colors.blue),),
              ),
              //------------------------------Esto se quita...solo es para navegar y ver las pantallas----------------------------

              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/landing');
                },
                child: const Text('Ver landing'),
              ),

              //------------------------------------------------------------------------------------------------------------------
            ],
          ),
        ),
      ),
    );
  }
}
