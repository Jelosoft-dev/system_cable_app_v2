import 'package:flutter/material.dart';
import '../components/settings.dart';

class MKCircularProgress extends StatelessWidget {
  final double strokeWidth;

  const MKCircularProgress({ Key? key,  this.strokeWidth = 2,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
              backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,// Cambia al color que desees
              strokeWidth : strokeWidth, 
            );
  }
}
