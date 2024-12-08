import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/modules/superadmin/data/models/admin_model.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/admin_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/entities/institution_entity.dart';
import 'package:sigede_flutter/modules/superadmin/domain/use_cases/admin_cases/admin_use_case.dart';
import 'package:sigede_flutter/modules/superadmin/presentation/pages/edit_admin.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class CustomListAdmin extends StatefulWidget {
  final AdminEntity? admins;
  final InstitutionEntity? institution;
  const CustomListAdmin({super.key, this.admins, this.institution});

  @override
  State<CustomListAdmin> createState() => _CustomListAdminState();
}

class _CustomListAdminState extends State<CustomListAdmin> {
  late bool isActive;
  @override
  void initState() {
    super.initState();
    // Inicializa el estado del switch con la información recibida.
    isActive = widget.admins?.status == 'activo';
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

  void _showConfirmationDialog(bool newValue) async {
    bool? shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmación'),
          content: Text('¿Deseas cambiar el estado del administrador?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Usuario cancela
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Usuario confirma
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );

    // Ejecuta la lógica dependiendo de la elección
    if (shouldUpdate == true) {
      setState(() {
        isActive = newValue;
      });
      // Llamar a la petición aquí
      _changeStatus(newValue);
    }
  }

  GetIt getIt = GetIt.instance;
  Future<void> _changeStatus(bool newValue) async {
    try {      
      final model = UpdateAdminStatusModel(
        email: widget.admins!.email,
        status: isActive ? 'inactivo' : 'activo',
      );
      final changeStatus = getIt<UpdateAdminInfo>();
      final response = await changeStatus.call(model);
      if(response.status == 200){
        showSuccessDialog(context: context, message: 'Estado actualizado correctamente');
      }else{
        showErrorDialog(context: context, message: 'Error al actualizar el estado');
      }
    } catch (e) {
      // Manejo de errores
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
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
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Icon(
              Icons.admin_panel_settings,
              size: 40.0,
              color: Colors.grey,
            ),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.admins!.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  maxLines: 1, // Limita a una sola línea
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  widget.admins!.email,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.black87),
                  maxLines: 1, // Limita a una sola línea
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),            
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                color: Colors.grey[750],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditAdmin(
                              admin: widget.admins,
                              logo: widget.institution?.logo,
                              name: widget.institution?.name,
                            )));
              },
            ),
            Switch(
              inactiveThumbColor: Colors.red,
              inactiveTrackColor: Colors.red.withOpacity(0.5),
              activeTrackColor: Colors.green.withOpacity(0.5),
              thumbIcon: thumbIcon,
              value: isActive,
              activeColor: Colors.green,
              onChanged: (bool value) {
                _showConfirmationDialog(value);
              },
            )
          ],
        ),
      ),
    );
  }
}
