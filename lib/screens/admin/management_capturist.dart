import 'package:flutter/material.dart';
import 'package:sigede_flutter/kernel/utils/setupLocator.dart';
import 'package:sigede_flutter/screens/auth/models/capturista.dart';
import 'package:sigede_flutter/screens/auth/use_cases/get_capturista.dart';

class ManagementCapturist extends StatefulWidget {
  const ManagementCapturist({super.key});

  @override
  State<ManagementCapturist> createState() => _ManagementCapturistState();
}

class _ManagementCapturistState extends State<ManagementCapturist> {
  late GetCapturista getCapturista;
  List<Capturista> capturistas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCapturista = locator<GetCapturista>();
    _loadCapturistas();
  }

  Future<void> _loadCapturistas() async {
    try {
      final users = await getCapturista.call();
      setState(() {
        capturistas = users; // Actualiza la lista de capturistas
        isLoading = false; // Oculta el indicador de carga
      });
    } catch (e) {
      setState(() {
        isLoading =
            false; // Asegura que el loading desaparezca en caso de error
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al cargar capturistas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Capturistas',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: TextField(
                        decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            hintText: 'Buscar capturista',
                            labelText: 'Buscar capturista'),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              isLoading
                  ? const CircularProgressIndicator() // Indicador de carga
                  : capturistas.isEmpty
                      ? const Text('No hay capturistas disponibles.')
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: capturistas.map((capturista) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Card(
                                    elevation: 4,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: ListTile(
                                              leading: const Icon(
                                                Icons.account_circle,
                                              ),
                                              title: Text(
                                                capturista.nombre,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Text(capturista.correo),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.edit_outlined),
                                                color: Colors.grey,
                                                onPressed: () {
                                                  Navigator.pushNamed(
                                                    context,
                                                    '/editCapturist',
                                                    arguments: capturista,
                                                  );
                                                },
                                              ),
                                              Switch(
                                                value: capturista.isActive,
                                                activeColor: Colors.green,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    capturista.isActive =
                                                        value; // Actualiza localmente
                                                  });
                                                  // Aquí puedes hacer una llamada para actualizar el estado en la API
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/registerCapturist');
        },
        backgroundColor: Colors.black,
        child: const Icon(Icons.add),
      ),
    );
  }
}
