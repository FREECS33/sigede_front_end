import 'package:dio/dio.dart';
import 'package:sigede_flutter/data/models/capturist_model.dart';

class CapturistRepository {
  final Dio dio;
  final String baseUrl;

  CapturistRepository(this.dio, this.baseUrl);

  Future<void> registerCapturist(CapturistModel capturist) async {
    try{
      final response = await dio.post(
        '$baseUrl/api/capturists/register',
        data: capturist.toJson(),
      );
      if (response.statusCode != 200) {
        throw Exception('Error al registrar capturista: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error al registrar capturista: $e');
    }
  }
}