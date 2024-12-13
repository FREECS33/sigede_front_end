import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class DynamicFormScreen extends StatefulWidget {
  @override
  _DynamicFormScreenState createState() => _DynamicFormScreenState();
}

class _DynamicFormScreenState extends State<DynamicFormScreen> {
  final Dio _dio = Dio(BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? ''));
  final List<Map<String, dynamic>> _fields = [];
  int? institutionId;

  @override
  void initState() {
    super.initState();
    _loadInstitutionId();
  }

  Future<void> _loadInstitutionId() async {
    institutionId = await TokenService.getInstituionId();
  }

  void _addField() {
    setState(() {
      _fields.add({
        'tag': TextEditingController(),
        'type': 'Texto',
        'isInQr': false,
        'isRequired': false,
        'isInCard': false,
      });
    });
  }

  void _removeField(int index) {
    setState(() {
      _fields.removeAt(index);
    });
  }

  Future<void> _createFields() async {
    if (institutionId == null) {
      await showErrorDialog(
        context: context,
        message: 'Error: Institution ID no está disponible.',
      );
      return;
    }

    try {
      final List<Map<String, dynamic>> fieldsToCreate = _fields.map((field) {
        return {
          'tag': field['tag'].text,
          'type': field['type'],
          'isInQr': field['isInQr'],
          'isRequired': field['isRequired'],
          'isInCard': field['isInCard'],
        };
      }).toList();

      final response = await _dio.post(
        '/api/user-info/create-forms',
        queryParameters: {
          'institutionId': institutionId,
        },
        data: fieldsToCreate,
      );

      if (response.statusCode == 201) {
        await showSuccessDialog(
          context: context,
          message: 'Campos creados exitosamente.',
        );
        setState(() {
          _fields.clear();
        });
      }
    } catch (e) {
      await showErrorDialog(
        context: context,
        message: 'Error al crear campos: $e',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 30,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Formulario Credenciales',
              style: TextStyle(
                fontFamily: 'RubikOne',
                fontSize: 37,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _fields.length,
                itemBuilder: (context, index) {
                  final field = _fields[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: field['tag'],
                            decoration: InputDecoration(
                              labelText: 'Ingresa un nombre para el campo',
                              labelStyle: const TextStyle(
                                fontFamily: 'RubikOne',
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12.0),
                          DropdownButtonFormField<String>(
                            value: field['type'],
                            decoration: InputDecoration(
                              labelText: 'Tipo de dato',
                              labelStyle: const TextStyle(
                                fontFamily: 'RubikOne',
                                fontSize: 14,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: ['Texto', 'Número', 'Alfanumérico'].map((type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                field['type'] = value ?? 'Texto';
                              });
                            },
                          ),
                          const SizedBox(height: 12.0),
                          SwitchListTile(
                            title: const Text('Mostrar en QR',
                                style: TextStyle(
                                  fontFamily: 'RubikOne',
                                  fontSize: 12,
                                )),
                            value: field['isInQr'],
                            onChanged: (value) {
                              setState(() {
                                field['isInQr'] = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          SwitchListTile(
                            title: const Text('Es requerido',
                                style: TextStyle(
                                  fontFamily: 'RubikOne',
                                  fontSize: 12,
                                )),
                            value: field['isRequired'],
                            onChanged: (value) {
                              setState(() {
                                field['isRequired'] = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          SwitchListTile(
                            title: const Text('Mostrar en Tarjeta',
                                style: TextStyle(
                                  fontFamily: 'RubikOne',
                                  fontSize: 12,
                                )),
                            value: field['isInCard'],
                            onChanged: (value) {
                              setState(() {
                                field['isInCard'] = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _removeField(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addField,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(16),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createFields,
              child: const Text(
                'Guardar',
                style: TextStyle(
                  fontFamily: 'RubikOne',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}