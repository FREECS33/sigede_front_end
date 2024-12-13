import 'package:flutter/material.dart';

import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/credential_navigator.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/credentials/landing_crendential.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/form/credential_form.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/home/home_capturer.dart';
import 'package:sigede_flutter/modules/admin/presentation/screens/profile/profile_admin.dart';

class NavigationAdmin extends StatefulWidget {
  const NavigationAdmin({super.key});

  @override
  State<NavigationAdmin> createState() => _NavigationAdminState();
}

class _NavigationAdminState extends State<NavigationAdmin> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static final List<Widget> _widgetOptions = <Widget>[
    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const HomeCapturer(),
        );
      },
    ),

    Navigator(
      key: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const CredentialNavigator(),
        );
      },
    ),
    DynamicFormScreen(),
    const ProfileAdmin()
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF917D62),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.badge_outlined),
              label: 'Credenciales',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_outlined),
              label: 'Formulario',
            ),            
            BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined),
              label: 'Perfil',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: const TextStyle(color: Colors.black),
          showUnselectedLabels: true,
          backgroundColor: const Color(0xFF917D62),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
