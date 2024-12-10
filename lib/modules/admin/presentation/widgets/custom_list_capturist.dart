import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sigede_flutter/modules/admin/domain/entities/capturista_entity.dart';
import 'package:sigede_flutter/modules/admin/domain/use_cases/update_capturista_status.dart';
import 'package:sigede_flutter/shared/widgets.dart/error_dialog.dart';
import 'package:sigede_flutter/shared/widgets.dart/success_dialog.dart';

class CustomListCapturist extends StatefulWidget {
  final CapturistaEntity capturista;
  const CustomListCapturist({Key? key, required this.capturista}) : super(key: key);

  @override
  State<CustomListCapturist> createState() => _CustomListCapturistState();
}

class _CustomListCapturistState extends State<CustomListCapturist> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    isActive = widget.capturista.status == 'activo';
  }

  void _showConfirmationDialog(bool newValue) async {
    bool? shouldUpdate = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const Text('¿Deseas cambiar el estado del capturista?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );

    if (shouldUpdate == true) {
      _changeStatus(newValue);
    }
  }

  Future<void> _changeStatus(bool newValue) async {
    try {
      final getIt = GetIt.instance;
      final updateCapturistaStatus = getIt<UpdateCapturistaStatus>();
      await updateCapturistaStatus.call(widget.capturista.email, newValue ? 'activo' : 'inactivo');

      setState(() {
        isActive = newValue;
      });

      showSuccessDialog(context: context, message: 'Estado actualizado correctamente');
    } catch (e) {
      showErrorDialog(context: context, message: 'Error al actualizar el estado');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: const BorderSide(color: Color(0xFF917D62), width: 1.5),
      ),
      child: ListTile(
        leading: const Icon(Icons.person, size: 40.0, color: Colors.grey),
        title: Text(
          widget.capturista.name,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.black),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          widget.capturista.email,
          style: const TextStyle(fontSize: 12.0, color: Colors.black87),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Switch(
          value: isActive,
          activeColor: Colors.green,
          inactiveThumbColor: Colors.red,
          inactiveTrackColor: Colors.red.withOpacity(0.5),
          onChanged: _showConfirmationDialog,
        ),
      ),
    );
  }
}
