import 'package:flutter/material.dart';
import 'package:sigede_flutter/screens/AdministratorManagementScreen.dart';
import 'package:sigede_flutter/screens/admin/credential_form.dart';
import 'package:sigede_flutter/screens/admin/edit_capturist.dart';
import 'package:sigede_flutter/screens/admin/management_capturist.dart';
import 'package:sigede_flutter/screens/admin/register_capturist.dart';
import 'package:sigede_flutter/screens/public/preview_qr.dart';

class NavigationAdmin extends StatefulWidget {
  const NavigationAdmin({super.key});

  @override
  State<NavigationAdmin> createState() => _NavigationAdminState();
}

class _NavigationAdminState extends State<NavigationAdmin> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    Administratormanagementscreen(),
    CredentialForm(),
    ManagementCapturist(),
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
            icon: Icon(Icons.sd_card),
            label: 'Credential-form',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_document),
            label: 'Capturistas',
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