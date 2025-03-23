import 'package:flutter/material.dart';
import '../components/settings.dart';

class MKModalConfirm extends StatelessWidget {
  final String titulo;

  const MKModalConfirm({
    Key? key,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(titulo),
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
        ElevatedButton(
          child: const Text(
            "Cancelar",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          onPressed: () {
            Navigator.of(context).pop(false); // Cerrar diálogo y pasar false
          },
        ),
      ],
    );
  }
}
