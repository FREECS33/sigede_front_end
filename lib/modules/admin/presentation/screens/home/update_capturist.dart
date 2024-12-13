import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/admin_cases/admin_use_case.dart';
import 'package:sigede_flutter/shared/services/token_service.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';
import 'package:sigede_flutter/shared/widgets.dart/loading_widget.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class UpdateCapturist extends StatefulWidget {
  final CapturistaEntity? capturista;
  final bool? status;
const UpdateCapturist({ super.key, this.status, this.capturista });

  @override
  State<UpdateCapturist> createState() => _UpdateCapturistState();
}

class _UpdateCapturistState extends State<UpdateCapturist> {
  String? logo;
  String? name;
  late bool isActive;
  late String _name = '';
  late bool _status = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameAdminController = TextEditingController();
  bool _isLoading = false;
  bool _isValidAdminName = true;
  @override
  void initState() {
    super.initState();
    isActive = widget.status ?? false;    
    _nameAdminController = TextEditingController(text: widget.capturista?.name ?? '');
    _name = widget.capturista?.name ?? '';
    _status = widget.capturista?.status == 'activo';
    Future.delayed(Duration.zero, () async {
      await loadData();
    });
  }
  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      logo = await TokenService.getLogo();
      name = await TokenService.getInstitutionName();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  void dispose() {
    // Asegúrate de limpiar el controlador
    _nameAdminController.dispose();
    super.dispose();
  }
  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  String? validateNameAdmin(String? value) {    
    if (value == null || value.isEmpty) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'Campo obligatorio';
    }
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');
    if (!nameRegExp.hasMatch(value)) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'Solo se permiten letras';
    }
    if (value.trim() != value) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'No debe contener espacios al inicio o al final';
    }
    if (value.length > 50) {
      setState(() {
        _isValidAdminName = false;
      });
      return 'No debe superar los 50 caracteres';
    }
    setState(() {
      _isValidAdminName = true;
    });
  }

  GetIt getIt = GetIt.instance;
  Future<void> _editAdmin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }    
    if (isActive == _status && _name == _nameAdminController.text) {
      showErrorDialog(
          context: context, message: 'Necesitas cambiar al menos un campo');
      return;
    }
    setState(() {
      _isLoading = true;
    });
    try {
      final UpdateInfoAdminModel updateInfoAdminEntity = UpdateInfoAdminModel(
        userId: widget.capturista?.userAccountId ?? 0,
        name: _nameAdminController.text,
        status: isActive ? 'activo' : 'inactivo',
      );
      // Llamar al caso de uso para editar el administrador
      final updateAdmin = getIt<UpdateInfoAdmin>();
      final result = await updateAdmin.call(updateInfoAdminEntity);
      if (result.status == 200) {
        setState(() {
          _name = _nameAdminController.text;
          _status = isActive;
        });
        showSuccessDialog(
            context: context, message: 'Información actualizada correctamente');
      } else {
        //   // Mostrar mensaje de error
        showErrorDialog(
            context: context, message: 'Error al actualizar la información');
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
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
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [     
              const Text(
                    'Editar Administrador',
                    style: TextStyle(
                      fontFamily: 'RubikOne',
                      fontSize: 37,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center, // Asegura que el texto esté centrado
                  ),     
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      logo ?? '',
                      width: 125,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.image_not_supported,
                        size: 60.0,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 50),
                    SizedBox(
                      width: 150,
                      child: Text(
                        name ?? 'Nombre de la institución',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(                    
                          validator: validateNameAdmin,
                          controller: _nameAdminController,
                          decoration: InputDecoration(
                            labelText: 'Nombre administrador',
                            labelStyle: TextStyle(
                              color: _isValidAdminName
                                  ? Colors.grey // Si la validación es exitosa
                                  : Colors.red, // Si la validación falla
                            ),
                            suffixIcon: Icon(
                              Icons.admin_panel_settings_outlined,
                              color: _isValidAdminName ? Colors.grey : Colors.red,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(children: [
                          const Text(
                            'Cambiar estado del administrador',
                            style: TextStyle(
                              fontFamily: 'RubikOne',
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Switch(
                            inactiveThumbColor: Colors.red,
                            inactiveTrackColor: Colors.red.withOpacity(0.5),
                            activeTrackColor: Colors.green.withOpacity(0.5),
                            thumbIcon: thumbIcon,
                            value: isActive,
                            activeColor: Colors.green,
                            onChanged: (bool value) {
                              setState(() {
                                isActive = value;
                              });
                            },
                          )
                        ])
                      ]),
                ),
              ),
              const Expanded(child: Column()),
              Padding(
                padding: const EdgeInsets.only(bottom: 150.0),
                child: SizedBox(
                  width: 300,
                  height: 48,
                  child: ElevatedButton(
                    
                    onPressed: _isLoading ? null : _editAdmin,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.black,
                    ),
                    child: _isLoading
                        ? const LoadingWidget() // Mostrar loading si está cargando
                        : Text(
                            'Guardar',
                            style: GoogleFonts.roboto(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}