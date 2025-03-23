import 'package:flutter/material.dart';
import '../components/settings.dart';

class MKLoader extends StatelessWidget {
  final String? message;

  const MKLoader({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: 150,
            height: 150,
            child: CircularProgressIndicator(
              backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,// Cambia al color que desees
            ),
          ),
          if (message != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(message!),
            ),
        ],
      ),
    );
  }
}
