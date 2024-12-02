import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/modules/admin/data/models/capturista.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturista.dart';

class EditCapturist extends StatefulWidget {
  const EditCapturist({super.key});

  @override
  State<EditCapturist> createState() => _EditCapturistState();
}

class _EditCapturistState extends State<EditCapturist> {
  late int userAccountId;
  late GetCapturista getCapturista;
  Capturista? capturista;
  bool light = true;
  bool isLoading = true;
  bool? isActive;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCapturista = locator<GetCapturista>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtenemos el userId de los argumentos pasados
    final userId = ModalRoute.of(context)?.settings.arguments as int?;
    if (userId != null) {
      userAccountId = userId;
      _loadCapturista();
    } else {
      print("Error: No se ha proporcionado un userId");
      Navigator.pushReplacementNamed(context, '/navigation');
    }
  }

  Future<void> _loadCapturista() async {
  try {
    final user = await getCapturista.call(userId: userAccountId);
    if (user != null) {
      setState(() {
        capturista = user;
        isLoading = false;
        _nameController.text = capturista!.name;
        _emailController.text = capturista!.email;
        isActive = capturista!.status == 'activo';
      });
    } else {
      print("Error: No se ha recibido un capturista válido");
      Navigator.pushReplacementNamed(context, '/navigation');
    }
  } on DioException catch (e) {
    setState(() {
      isLoading = false;
    });
    print("Error $e");
  }
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

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un nombre';
    } else if (value.length < 3) {
      return 'Ingrese un nombre valido';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Switch(
                          value: isActive ??
                              false, // Si isActive es null, lo considera como false
                          activeColor: Colors.green,
                          onChanged: (bool value) {
                            setState(() {
                              isActive = value;
                            });
                          },
                        )
                      ],
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Editar Capturista',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
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
                                suffixIcon:
                                    Icon(Icons.sensor_occupied_rounded)),
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
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  Navigator.pushNamed(
                                      context, '/managementCapturist');
                                }
                              },
                              child: const Text(
                                'Editar',
                                style: TextStyle(fontSize: 22),
                              ),
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