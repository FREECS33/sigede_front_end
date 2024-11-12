import 'package:flutter/material.dart';

class ManagementCapturist extends StatefulWidget {
  const ManagementCapturist({super.key});

  @override
  State<ManagementCapturist> createState() => _ManagementCapturistState();
}

class _ManagementCapturistState extends State<ManagementCapturist> {

  // ESTO ES ESTATICO PARA EL SWITCH, CUANDO SE CONSUMA LA API, ESTO NO EXISTIRA
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 12,),
              const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Capturistas',
                  style: TextStyle(fontSize: 24),
                ),
              ]),
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
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      for (int i = 1; i <= 10; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      leading: const Icon(Icons.account_circle,),
                                      title: Text(
                                        'Capturista $i',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      subtitle: const Text('capturista@utez.edu.mx'),
                                   ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit_outlined),
                                        color: Colors.grey,
                                        onPressed: () {
                                          Navigator.pushNamed(context, '/editCapturist');
                                        },
                                      ),
                                      Switch(
                                        value: light, 
                                        activeColor: Colors.green,
                                        onChanged: (bool value) {
                                        setState(() {
                                          light=value;
                                        });
                                      },
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pushNamed(context, '/registerCapturist');
      },backgroundColor: Colors.black,child: const Icon(Icons.add),),
    );
  }
}
