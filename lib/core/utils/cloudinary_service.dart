import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CloudinaryService {
  final Dio _dio = Dio();

  // Accede a las variables de configuración
  final String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? '';
  final String apiKey = dotenv.env['CLOUDINARY_API_KEY'] ?? '';
  final String apiSecret = dotenv.env['CLOUDINARY_API_SECRET'] ?? '';

  CloudinaryService();

  // URL para la carga de imágenes
  String get uploadUrl => 'https://api.cloudinary.com/v1_1/$cloudName/image/upload';

  Future<String?> uploadImage(File image) async {
    try {
      // Preparamos la solicitud
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(image.path),
        'upload_preset': 'pokemon', // Asegúrate de tener un preset configurado en Cloudinary
      });

      // Configuramos el encabezado de la solicitud
      final response = await _dio.post(uploadUrl, data: formData);

      // Verificar la respuesta
      print('Response: ${response.data}');

      if (response.statusCode == 200) {
        // La respuesta contiene la URL de la imagen subida
        final String imageUrl = response.data['secure_url'];
        return imageUrl; // Devuelve la URL de la imagen subida
      } else {
        throw Exception('Error al subir la imagen: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al subir la imagen: $e');
      return null; // Retorna null en caso de error
    }
  }
}

