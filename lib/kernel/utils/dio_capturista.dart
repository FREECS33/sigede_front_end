import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl})
      : _dio = Dio(BaseOptions(baseUrl: baseUrl)){
    // Habilitar logs
    _dio.interceptors.add(LogInterceptor(
      request: true, // Mostrar solicitudes
      requestBody: true, // Mostrar el cuerpo de las solicitudes
      responseBody: true, // Mostrar el cuerpo de las respuestas
      responseHeader: false, // Ocultar encabezados de respuesta
      error: true, // Mostrar errores
      logPrint: (obj) => print(obj), // Personalizar impresión de logs (opcional)
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.get(path, queryParameters: queryParameters);
  }

  Future<Response> post(String path, {dynamic data}) async {
    return _dio.post(path, data: data);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters}) async {
    return _dio.delete(path, queryParameters: queryParameters);
  }
}
