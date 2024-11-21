import 'package:flutter/material.dart';
import 'package:sigede_flutter/kernel/utils/setupLocator.dart';
import 'package:sigede_flutter/screens/auth/models/capturista.dart';
import 'package:sigede_flutter/screens/auth/use_cases/get_capturista.dart';
import 'package:sigede_flutter/screens/auth/use_cases/update_capturista.dart';

class EditCapturist extends StatefulWidget {
  final String id;

  const EditCapturist({Key? key, required this.id}) : super(key: key);

  @override
  State<EditCapturist> createState() => _EditCapturistState();
}

class _EditCapturistState extends State<EditCapturist> {
  bool light = true;
  bool _isObscure = true;
  bool _isObscure2 = true;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  final UpdateCapturista updateCapturista = locator<UpdateCapturista>();
  final GetCapturista getCapturista = locator<GetCapturista>();

  @override
  void initState() {
    super.initState();
    _fetchCapturistaData();
  }

  Future<void> _fetchCapturistaData() async {
    try {
      final capturista = await getCapturista(widget.id);
      setState(() {
        _nameController.text = capturista.nombre ?? '';
        _emailController.text = capturista.correo ?? '';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar datos: $e')),
      );
    }
  }

  Future<void> _updateCapturista() async {
    if (_formKey.currentState!.validate()) {
      final capturista = Capturista(
        id: widget.id,
        nombre: _nameController.text,
        correo: _emailController.text,
        password: _passwordController.text,
      );

      try {
        await updateCapturista.call(capturista);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Capturista actualizado correctamente')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al actualizar: $e')),
        );
      }
    }
  }

  String? _validateEmail(String? value) {
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

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    }
    return null;
  }

  String? _validatePasswordConfirm(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese una contraseña';
    } else if (value != _passwordController.text) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un nombre';
    } else if (value.length < 3) {
      return 'Ingrese un nombre válido';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Capturista'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
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
                    },
                  ),
                ],
              ),
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/5/54/Logo-utez.png/460px-Logo-utez.png',
                height: 90,
                width: 110,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.person),
                ),
                validator: _validateName,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.email),
                ),
                validator: _validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
                validator: _validatePassword,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordConfirmController,
                obscureText: _isObscure2,
                decoration: InputDecoration(
                  labelText: 'Confirmar Contraseña',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isObscure2 ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscure2 = !_isObscure2;
                      });
                    },
                  ),
                ),
                validator: _validatePasswordConfirm,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updateCapturista,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Text('Actualizar', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}