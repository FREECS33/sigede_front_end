import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/landing.dart';

class Navigation extends StatefulWidget {
  const Navigation({
    super.key,
  });
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  // ignore: unused_field
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[Landing()];

  void _onItemTapped(int index) {
    //es obligatorio
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
          color:
              const Color(0xFF917D62), // Color de fondo del BottomNavigationBar
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Color de la sombra
              spreadRadius: 0, // Cuánto se extiende la sombra
              blurRadius: 10, // Qué tan difusa es la sombra
              offset: const Offset(0,
                  -5), // Desplazamiento de la sombra (en este caso hacia arriba)
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
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
