import '../components/settings.dart';
import '../components/input_detail_text.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          nombreApp,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
        // brightness: Brightness.dark,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          padding: const EdgeInsets.only(
              top: 15, left: 10.0, right: 10.0, bottom: 10.0),
          children: <Widget>[
            const Center(
                child: Text(
              'Acerca de',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            )),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, bottom: 18.0),
              child: Image.asset(
                SettingsApp[app_sucursal]!['logo'] as String,
                // width: MediaQuery.of(context).size.width / 2,
                height: 150,
              ),
            ),
            const DetailText(
                texto:
                    'Esta herramienta disponible para Android permite al cobrador registrar el pago de las cuotas de los clientes que están al día y emitir un comprobante de pago de uso interno..'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const DetailText(
                texto:
                    'Los comprobantes emitidos por esta aplicación puede ser enviado en formato pdf o entregar de forma impresa.'),
            const Padding(padding: EdgeInsets.only(top: 10)),
            const DetailText(
                texto:
                    'Esta aplicación se encuentra en fase de desarrollo, por ende, toda información para la mejora del mismo pueden ser remitidas al correo jelosoft19@gmail.com lo cual será de gran utilidad.'),
            const Padding(padding: EdgeInsets.only(top: 10.0)),
          ],
        ),
      ),
    );
  }
}
