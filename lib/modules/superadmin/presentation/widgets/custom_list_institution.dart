import 'package:flutter/material.dart';

class CustomListInstitution extends StatelessWidget {
  final String? logoUrl; // URL o path local para el logotipo
  final String? institutionName;
  final String? role;
  final String? location;
  const CustomListInstitution({
    super.key,
    this.logoUrl,
    this.institutionName,
    this.role,
    this.location,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Institución seleccionada: $institutionName'),
      child: Card(
        color: const Color(0xFFF6F5F5),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Color(0xFF917D62), // Color del borde
            width: 1.5, // Grosor del borde
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  logoUrl!,
                  height: 60.0,
                  width: 60.0,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    size: 60.0,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(width: 16.0),
              // Información de la institución
              Expanded(
                child: Column(
                  children: [
                    Text(
                      institutionName!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // Limita a una sola línea
                      overflow: TextOverflow
                          .ellipsis, // Agrega "..." al final si es demasiado largo
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      role!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      location!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}