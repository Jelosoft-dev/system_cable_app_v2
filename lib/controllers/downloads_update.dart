import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/request.dart';

class UpdateService {

  static ServiciosController serviciosCtrl = ServiciosController();
  String serveURL = serviciosCtrl.serveURL;

  Future<dynamic> checkForUpdate() async {
    var exiteActualizacion = {};
    final info = await PackageInfo.fromPlatform();

    await alertException(() async {
      var response = await request("GET", serveURL, 'api/downloads/consultar-actualizacion', params: {"proceso" : "SYSTEM_CABLE_APP", "version": info.version});
      if (jsonDecode(response['data']) != null)
        exiteActualizacion = jsonDecode(response['data']);
    });

    if (exiteActualizacion.containsKey("existe_actualizacion") && exiteActualizacion["existe_actualizacion"] == false)
      return false;

    String latestVersion = exiteActualizacion["version"] as String? ?? "0.0.0";
    final currentVersion = info.version;

    return {
      "existe_actualizacion" : _isNewerVersion(latestVersion, currentVersion),
      "nombre_archivo" : exiteActualizacion["nombre_archivo"],
    };
  }

  bool _isNewerVersion(String newVersion, String currentVersion) {
    final nv = newVersion.split('.').map(int.parse).toList();
    final cv = currentVersion.split('.').map(int.parse).toList();
    for (int i = 0; i < nv.length; i++) {
      if (nv[i] > cv[i]) return true;
      if (nv[i] < cv[i]) return false;
    }
    return false;
  }

  Future<void> downloadAndInstallApk(nombre_archivo) async {
    final dir = await getExternalStorageDirectory();
    final apkUrl = UrlRequest.UriURL('api/downloads/aplicacion-movil', params : {"nombre_archivo" : nombre_archivo}).toString();
    final path = "${dir!.path}/update.apk";

    final dio = Dio();
    try {
      await dio.download(
        apkUrl, 
        path,
        options: Options(
          headers: {
            ...await UrlRequest.Headers(),
          },
        ),);
    } catch (e) {
      print(e);
    }

    if (Platform.isAndroid) {
      InstallPlugin.installApk(path, appId : 'com.example.tv_cable')
          .catchError((e) => print('Error al instalar APK: $e'));
    }
  }
}
