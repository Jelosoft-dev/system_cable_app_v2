import 'package:package_info_plus/package_info_plus.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/controllers/downloads_update.dart';
import 'package:tv_cable/components/MKModal.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';

import '../components/settings.dart';
import '../components/input_detail_text.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  bool buscandoActualizacion = false;
  UpdateService updateService = new UpdateService();


  void modalActualizarApp(nombre_archivo) async {
    bool? resultado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModal(
          titulo: "Actualización Encontrada.",
          content: Text("¿Desea actualizar la Aplicación?"),
        );
      },
    );

    if (resultado != null && resultado) {
      setState(() {
        btnText = 'Descargando... 0%';
      });

      await updateService.downloadAndInstallApk(
        nombre_archivo,
        onProgress: (progress) {
          setState(() {
            btnText = 'Descargando... ${progress.toStringAsFixed(0)}%';
          });
        },
      );

      await obtenerVersion();
    }
  }


  

  Future<void> verificarActualizaciones() async {
    var update = await updateService.checkForUpdate();
    if(update != null && update != false 
        && update.containsKey("existe_actualizacion") 
        && update.containsKey("nombre_archivo") 
        && update["existe_actualizacion"]){
          modalActualizarApp(update["nombre_archivo"]);
    }else{
      mostrarAlerta("Ya tienes la versión más nueva.", "SUCCESS");
      btnText = 'Buscar Actualización';
      setState(() { });
    }
  }


  String appVersion = "";
  String btnText = 'Buscar Actualización';

  Future<void> obtenerVersion() async {
    final info = await PackageInfo.fromPlatform();
    appVersion = "Versión: " + info.version;
    setState(() { });
  }
  
  @override
  void initState() {
    super.initState();
    obtenerVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          SettingsApp[app_sucursal]!['name'] as String,
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
            DetailText(
                texto: appVersion, fuente : 13 ),
            const Padding(padding: EdgeInsets.only(top: 10)),
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
            
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              margin: const EdgeInsets.only(top: 15.0),
              child: ElevatedButton(
                    onPressed: buscandoActualizacion ? (){} : () async {
                      buscandoActualizacion = true;
                      btnText = "Buscando...";
                      setState(() { });
                      await verificarActualizaciones();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      elevation: 0.0,
                      shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
                    ),
                    child: Text(btnText,
                        style: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
            )
            
          ],
        ),
      ),
    );
  }
}
