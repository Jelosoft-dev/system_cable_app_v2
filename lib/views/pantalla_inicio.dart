import 'package:tv_cable/components/MKTemplateScreen.dart';

import 'package:tv_cable/components/settings.dart';
import 'package:flutter/material.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({Key? key}) : super(key: key);

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
