import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';

class DioClient {
  final Dio _dio;

  DioClient()
      : _dio = Dio(
          BaseOptions(
          baseUrl: dotenv.env['BASE_URL']?? '',
            headers: {
              'Authorization': '',
              'Content-Type': 'application/json',
            },
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 20),
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
      final token = await TokenService.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      handler.next(options);
    },
      onResponse: (response, handler) {
        if (response.statusCode == 200) {
          handler.next(response);
        } else {
          handler.reject(
            DioException(
              requestOptions: response.requestOptions,
              response: response,
            ),
          );
        }
      },
      onError: (error, handler) {
        // Handle specific status codes
        if (error.response != null) {
          switch (error.response?.statusCode) {
            case 400:
              print("Bad Request");
              break;
            case 401:
              print("Unauthorized");
              break;
            case 403:
              print("Unauthorized");
              break;
            case 500:
              print("Internal Server Error");
              break;
            default:
              print("Unhandled Error: ${error.response?.statusCode}");
          }
        }
        handler.next(error);
      },
    ));
  }

  Dio get dio => _dio;
}
