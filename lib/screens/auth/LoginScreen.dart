import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  bool _isObscure = true;

  String? validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese su correo electrónico';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Por favor, ingrese un correo electrónico válido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    validator: validateEmail,
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Correo electrónico',
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 199, 197, 197), filled: true,
                      //label: Text('Correo electrónico'),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    obscureText: _isObscure,
                    validator: validatePassword,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                      hintText: 'Contraseña',
                      border:const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15)),borderSide: BorderSide.none),
                      fillColor: const Color.fromARGB(255, 199, 197, 197), filled: true,
                      //label: const Text('Contraseña'),
                      suffixIcon: IconButton(onPressed: (){
                        setState(() {
                          _isObscure=!_isObscure;
                        });
                      }, icon: Icon(_isObscure?Icons.visibility:Icons.visibility_off)),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    width: 200,
                    child: ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        Navigator.pushReplacementNamed(context, '/landing');
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: const Text('Iniciar sesión',style:TextStyle(color:Colors.white),),),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    child: ElevatedButton(onPressed: () {
                      Navigator.pushNamed(context, '/recoverPassword');
                    },
                    style: OutlinedButton.styleFrom(
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ), child: const Text('Olvide la contraseña',style: TextStyle(decoration: TextDecoration.underline,color: Colors.black),),),
                  ),  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}