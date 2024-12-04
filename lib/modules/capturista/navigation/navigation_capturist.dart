import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/capturista/presentation/pages/credentials_management.dart';
import 'package:sigede_flutter/modules/capturista/presentation/pages/register_credential.dart';

class NavigationCapturist extends StatefulWidget {
  const NavigationCapturist({super.key});

  @override
  State<NavigationCapturist> createState() => _NavigationCapturistState();
}

class _NavigationCapturistState extends State<NavigationCapturist> {

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    CredentialsManagement(),
    RegisterCredential()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add_alt),
            label: 'Registrar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
        unselectedItemColor: const Color.fromARGB(255, 169, 167, 167),
        showUnselectedLabels: true,
        
      ),
    );
  }
}