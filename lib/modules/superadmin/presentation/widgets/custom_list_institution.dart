import 'package:flutter/material.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_entity.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/admin_page.dart';

class CustomListInstitution extends StatelessWidget {
  final InstitutionEntity institutions;
  const CustomListInstitution({
    super.key,
    required this.institutions,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage(institutions: institutions,))),
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.network(
                  institutions.logo,
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
                      institutions.name,
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
                    const Text(
                      "correo electrónico",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      institutions.emailContact,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.black87,
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
