import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio;

  DioClient({required String baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: {
              'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdXRob3JpdGllcyI6Ilt7XCJhdXRob3JpdHlcIjpcImNhcHR1cmlzdGFcIn1dIiwic3ViIjoidWxpQGdtYWlsLmNvbSIsImlhdCI6MTczMjkwOTE5MiwiZXhwIjoxNzMyOTEyNzkyfQ.CNAmBpcQcRzbCKdkN0QjlOMFW42y1UdJ-jxtUJn2lBs',
              'Content-Type': 'application/json',
            },
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 20),
          ),
        ) {
    _dio.interceptors.add(InterceptorsWrapper(
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
