// import '../models/trabajo_tecnico.dart';
import 'package:tv_cable/models/config_caja.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/request.dart';
import '../controllers/servicios_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  UserController();

  //Registrar nuevo coche
  //function for register products
  // Future<Respuesta> cambiarPassword(
  //     String id, String pass, String passNew, String passNew2) async {
  //   http.Response response =
  //       await http.post(Uri.parse(serveURL + '/passwordupdate'), headers: {
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ' + (await serviciosCtrl.read()).toString()
  //   }, body: {
  //     'id': id,
  //     'passwordA': pass,
  //     'password1': passNew,
  //     'password2': passNew2,
  //   });

  //   Respuesta respuesta = Respuesta("", "");

  //   var varResponse = json.decode(response.body);
  //   respuesta.status = response.statusCode.toString();
  //   respuesta.msg = varResponse['msg'];

  //   return respuesta;
  // }

  // Future<Respuesta> destroyToken() async {
  //   Respuesta respuesta = Respuesta("", "");
  //   try {
  //     http.Response response = await http.post(
  //         Uri.parse(serveURL + 'cerrarSesion.php'),
  //         body: {'token': (await serviciosCtrl.read()).toString()});

  //     var varResponse = json.decode(response.body);
  //     // respuesta.status = response.statusCode.toString();
  //     respuesta.status = varResponse['status'].toString();
  //     if (respuesta.status == '500' && await serviciosCtrl.cerrarSesion()) {
  //       respuesta.msg = 'Token destruido';
  //     } else {
  //       respuesta.msg = 'No hay respuesta de servidor';
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print(e);
  //   }
  //   return respuesta;
  // }

  Future<CajaModel> obtenerDetallesCaja(String idUser) async {
    CajaModel registro = CajaModel();
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/usuario/${idUser}/config-caja');
      if (jsonDecode(response['data']) != null)
        registro = CajaModel.fromJson(jsonDecode(response['data']));
    });
    return registro;
  }

}
