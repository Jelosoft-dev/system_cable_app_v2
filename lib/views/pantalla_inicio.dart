import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/settings.dart';
import 'package:flutter/material.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({Key? key}) : super(key: key);

  @override
  _PantallaInicioState createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {

  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      body: Center(
        child: Image.asset(
          SettingsApp[app_sucursal]!['logo'] as String,
          height: 170,
        ),
      ),
    );
  }
}

