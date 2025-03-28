import 'package:flutter/material.dart';
import '../components/settings.dart';

class MKLoader extends StatelessWidget {
  final String? message;
  final double width;
  final double height;

  const MKLoader({
    Key? key, 
    this.message,
    this.width = 150,
    this.height = 150,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            width: this.width,
            height: this.height,
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
