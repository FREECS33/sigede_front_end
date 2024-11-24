import 'package:flutter/material.dart';
import 'package:sigede_flutter/screens/auth/data/models/capturista.dart';

class EditCapturist extends StatefulWidget {
  const EditCapturist({super.key});

  @override
  State<EditCapturist> createState() => _EditCapturistState();
}

class _EditCapturistState extends State<EditCapturist> {
  late Capturista capturista; 
  bool light = true;
  bool _isObscure = true;
  bool _isObscure2 = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    capturista = ModalRoute.of(context)!.settings.arguments as Capturista;

    _nameController.text = capturista.name;
    _emailController.text = capturista.email;
  }

  String? validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un correo electrónico';
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

  String? validatePasswordConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    } else if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    } else {
      return null;
    }
  }

  String? validateName(String? value){
    if(value == null || value.isEmpty){
      return 'Ingrese un nombre';
    }else if(value.length < 3){
      return 'Ingrese un nombre valido';
    }else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Switch(
                      value: light,
                      activeColor: Colors.green,
                      onChanged: (bool value) {
                        setState(() {
                          light = value;
                        });
                      })
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Editar Capturista',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Logo-utez.png/460px-Logo-utez.png',
                      height: 90,
                      width: 110,
                    ),
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  const Expanded(
                    flex: 2,
                    child: Text(
                      'Universidad Tecnológica Emiliano Zapata',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    TextFormField(
                      validator: validateName,
                      controller: _nameController,
                      decoration: const InputDecoration(
                          labelText: 'Nombre de Capturista',
                          hintText: 'Nombre de Capturista',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          suffixIcon: Icon(Icons.sensor_occupied_rounded)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      validator: validateEmail,
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'Correo electrónico',
                          hintText: 'Correo electrónico',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          suffixIcon: Icon(Icons.email_outlined)),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      validator: validatePassword,
                      obscureText: _isObscure,
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          hintText: 'Contraseña',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                        validator: validatePasswordConfirm,
                        obscureText: _isObscure2,
                        controller: _passwordConfirmController,
                        decoration: InputDecoration(
                          labelText: 'Confirmar contraseña',
                          hintText: 'Confirmar contraseña',
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isObscure2 = !_isObscure2;
                                });
                              },
                              icon: Icon(_isObscure2
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                        )),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/managementCapturist');
                        }
                      },
                      child: const Text('Editar',style: TextStyle(fontSize: 22),),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
