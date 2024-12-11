import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/credential_entity.dart';

class CustomListCredential extends StatefulWidget {
  final ResponseCredentialInstitutionEntity credential;
  const CustomListCredential({super.key, required this.credential});

  @override
  State<CustomListCredential> createState() => _CustomListCredentialState();
}

class _CustomListCredentialState extends State<CustomListCredential> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vigencias'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Dos columnas
            crossAxisSpacing: 10, // Espaciado horizontal
            mainAxisSpacing: 10, // Espaciado vertical
            childAspectRatio: 3 / 2, // Proporción de la tarjeta
          ),
          itemCount: 8, // Número de tarjetas
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      'https://via.placeholder.com/80', // Reemplaza con tu imagen
                      width: 80,
                      height: 80,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Vigencia:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '22/12/2025',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
