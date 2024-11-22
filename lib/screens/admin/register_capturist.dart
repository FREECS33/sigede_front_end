import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:sigede_flutter/data/models/capturist_model.dart';
import 'package:sigede_flutter/data/repositories/capturist_repository.dart';
import 'package:sigede_flutter/usecases/register_capturist_use_case.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterCapturist extends StatefulWidget {
  const RegisterCapturist({super.key});

  @override
  State<RegisterCapturist> createState() => _RegisterCapturistState();
}

class _RegisterCapturistState extends State<RegisterCapturist> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  late RegisterCapturistUseCase registerCapturistUseCase;

  @override
  void initState() {
    super.initState();
    final dio = Dio();
    final repository = CapturistRepository(dio, 'http://localhost:8080');
    registerCapturistUseCase = RegisterCapturistUseCase(repository);
  }

  String? validateEmail(String? value) {
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (value == null || value.isEmpty) {
      return 'Por favor, ingrese un correo electrónico';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Por favor, ingrese un correo electrónico válido';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un nombre';
    } else if (value.length < 3) {
      return 'Ingrese un nombre válido';
    }
    return null;
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final capturist = CapturistModel(
        name: _nameController.text,
        email: _emailController.text,
        fkInstitution: 1,
      );

      try {
        await registerCapturistUseCase.call(capturist); 
        Fluttertoast.showToast(
          msg: 'Capturista registrado con éxito',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
        );
        Navigator.pushNamed(context, '/managementCapturist');

      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Error al registrar capturista',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP_RIGHT,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
        );
      }
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
              const SizedBox(height: 32,),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                    'Registrar',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Capturista',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                    ],
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
                      height: 16,
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
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: _submit,
                        child: const Text('Guardar',style: TextStyle( fontSize: 22,),),
                      ),
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