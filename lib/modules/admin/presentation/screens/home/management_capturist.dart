import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/get_capturistas.dart';
import 'package:sigede_flutter/modules/admin/presentation/widgets/custom_list_capturist.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';

class CapturistasScreen extends StatefulWidget {
  const CapturistasScreen({Key? key}) : super(key: key);

  @override
  State<CapturistasScreen> createState() => _CapturistasScreenState();
}

class _CapturistasScreenState extends State<CapturistasScreen> {
  final GetIt getIt = GetIt.instance;
  bool _isLoading = false;
  bool _notData = false;
  List<CapturistaEntity> capturistas = [];

Future<void> _getAllCapturistas() async {
  setState(() {
    _isLoading = true;
    _notData = false;
  });
  try {
    final institutionId = await TokenService.getInstituionId();
    if (institutionId == null) {
      throw Exception("Institution ID no encontrado.");
    }
    final getCapturistasUseCase = getIt<GetCapturistas>();
    final result = await getCapturistasUseCase.call(institutionId);

    if (result.isEmpty) {
      setState(() {
        _notData = true;
      });
    } else {
      setState(() {
        capturistas = result;
      });
    }
  } catch (e) {
    setState(() {
      _notData = true;
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}


  @override
  void initState() {
    super.initState();
    _getAllCapturistas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Capturistas"),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _getAllCapturistas,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Capturistas',
                style: TextStyle(
                  fontFamily: 'RubikOne',
                  fontSize: 37,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              _isLoading
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      ),
                    )
                  : _notData
                      ? const Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                                Text(
                                  "No se encontraron capturistas",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: capturistas.length,
                            itemBuilder: (context, index) {
                              return CustomListCapturist(
                                capturista: capturistas[index],
                              );
                            },
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
