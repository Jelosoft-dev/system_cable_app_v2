import 'package:flutter/material.dart';
import 'package:tv_cable/components/settings.dart';

class MKModal extends StatelessWidget {
  final String titulo;
  final Widget content;

  const MKModal({
    Key? key,
    required this.titulo,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(titulo),
      content: content,
      actions: <Widget>[
        ElevatedButton(
         child: const Text("Aceptar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              )),
          style: ElevatedButton.styleFrom(
            backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
          ),
          onPressed: () {
            Navigator.of(context).pop(true); // Cerrar diálogo y pasar true
          },
        ),
        // ElevatedButton(
        //   child: const Text(
        //     "Cancelar",
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontSize: 18.0,
        //     ),
        //   ),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.red,
        //     elevation: 0.0,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(25.0),
        //     ),
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pop(false); // Cerrar diálogo y pasar false
        //   },
        // ),
      ],
    );
  }
}
