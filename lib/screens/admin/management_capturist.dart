import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sigede_flutter/core/utils/locator.dart';
import 'package:sigede_flutter/screens/auth/data/models/capturista.dart';
import 'package:sigede_flutter/screens/auth/domain/use_cases/get_capturistas.dart';

class ManagementCapturist extends StatefulWidget {
  const ManagementCapturist({super.key});

  @override
  State<ManagementCapturist> createState() => _ManagementCapturistState();
}

class _ManagementCapturistState extends State<ManagementCapturist> {
  late GetCapturistas getCapturistas;
  List<Capturista> capturistas = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getCapturistas = locator<GetCapturistas>();
    _loadCapturistas();
  }

  Future<void> _loadCapturistas() async {
  try { 
    final role = "capturista";
    final institutionId = 1;

    final users = await getCapturistas.call(
      role: role,
      institutionId: institutionId,
    );
    setState(() {
      capturistas = users;
      isLoading = false;
    });
  } on DioError catch (e) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error de red: ${e.message}')),
    );
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error inesperado: $e')),
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
                  ? const CircularProgressIndicator()
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
                                                capturista.name,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              subtitle: Text(capturista.email),
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
                                              // Switch(
                                              //   value: capturista.isActive,
                                              //   activeColor: Colors.green,
                                              //   onChanged: (bool value) {
                                              //     setState(() {
                                              //       capturista.isActive =
                                              //           value; // Actualiza localmente
                                              //     });
                                              //     // Aquí puedes hacer una llamada para actualizar el estado en la API
                                              //   },
                                              // )
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
