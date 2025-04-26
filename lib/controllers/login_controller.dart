import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/request.dart';

import '../controllers/servicios_controller.dart';
import '../models/auth.dart';
import 'dart:convert';

class LoginController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  Future<Auth> iniciarSesion(String usuario, pass) async {
    Map data = {'usuario': usuario, 'password': pass};
    Auth jsonResponse = Auth();
    await alertException(() async {
      var response = await request("POST", serveURL, 'api/auth/login', body: data);
      print(response['data']);
      jsonResponse = Auth.fromJson(jsonDecode(response['data']));
    }, shouldRethrow : false);
    return jsonResponse;
  }

  Future<bool> cerrarSesion() async {
    bool response = true;
    await alertException(() async {
      await request("POST", serveURL, 'api/auth/logout');
      await serviciosCtrl.cerrarSesion();
    });
    return response;
  }
}
