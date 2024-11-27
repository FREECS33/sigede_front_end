import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/modules/public/preview_qr.dart';

class NavigationAdmin extends StatefulWidget {
  const NavigationAdmin({super.key});

  @override
  State<NavigationAdmin> createState() => _NavigationAdminState();
}

class _NavigationAdminState extends State<NavigationAdmin> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Administratormanagementscreen(),
    PreviewQR()
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
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'preview-qr',
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