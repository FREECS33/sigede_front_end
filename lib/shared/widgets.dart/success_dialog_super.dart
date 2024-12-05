import 'package:flutter/material.dart';

Future<void> showSuccessDialogSuper(
    {required BuildContext context,
    required String message,
    required VoidCallback onPressed}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: Icon(
          size: 50,
          Icons.check_circle,
          color: Colors.green[600], // Color verde para éxito
        ),
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Center(
            child: SizedBox(
              width: 100,
              height: 40,
              child: TextButton(
                onPressed: () {
                  // Ejecutar la acción pasada como callback
                  onPressed();
                  Navigator.of(context).pop(); // Cerrar el dialog
                },
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black, // Botón verde
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'Aceptar',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}