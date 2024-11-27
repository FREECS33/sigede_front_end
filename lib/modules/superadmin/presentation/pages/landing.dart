import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Asegura que ambos textos comiencen en el mismo punto horizontal
          children: [
            Text(
              'Clientes',
              style: GoogleFonts.rubikMonoOne(
                textStyle: const TextStyle(
                  fontSize: 30,
                  height: 1.2, // Ajusta la altura de línea
                ),
              ),
            ),
            Text(
              'Todos los clientes',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 16, // Define explícitamente el tamaño
                  color: Colors.grey,
                  height: 1.2, // Mantén la misma altura de línea
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Center(
              child: Container(
                width: 300, // Ajusta el ancho según lo necesites
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color:
                      const Color(0xFFF6F5F5), // Color de fondo del TextField
                  borderRadius: BorderRadius.circular(25), // Bordes redondeados
                  border: Border.all(
                    color: const Color(0xFF917D62), // Color del borde
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(0.2), // Color de la sombra
                      spreadRadius: 1, // Cuánto se expande la sombra
                      blurRadius: 8, // Cuán difusa es la sombra
                      offset: const Offset(0, 4), // Sombra hacia abajo
                    ),
                  ],
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: 'Buscar cliente', // Texto placeholder
                      hintStyle: TextStyle(
                          color: Colors.grey), // Color del placeholder
                      border: InputBorder.none, // Quita el borde predeterminado
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey, // Icono de búsqueda
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
