import '../components/settings.dart';
import '../views/pantalla_inicio.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: SettingsApp[app_sucursal]!['name'] as String,
        debugShowCheckedModeBanner: false,
        home: const PantallaInicio(),
        theme: ThemeData(
          unselectedWidgetColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
          primarySwatch: SettingsApp[app_sucursal]!['PrimaryLightColor'] as MaterialColor,
        ));
  }
}
