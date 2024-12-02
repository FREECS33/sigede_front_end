import 'package:dio/dio.dart';
import 'package:sigede_flutter/core/utils/dio_client.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/institution_new_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_new_entity.dart';

abstract class InstitutionPostDataSource {
  Future<InstitutionNewEntity> postInstitution(InstitutionNewModel model);
}

class InstitutionPostDataSourceImpl implements InstitutionPostDataSource {
  final DioClient dioClient;

  InstitutionPostDataSourceImpl({required this.dioClient});

  @override
  Future<InstitutionNewEntity> postInstitution(InstitutionNewModel model) async {
    try {
      final response = await dioClient.dio.post(
        '/api/institutions/post-institution',
        data: model.toJson(),
      );

      if (response.statusCode != null &&
          response.statusCode! >= 200 &&
          response.statusCode! < 300) {
        return InstitutionNewModel.fromJson(response.data);
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
        );
      }
    } catch (e) {
      throw Exception('Error posting institution: $e');
    }
  }
}
  