import 'package:tv_cable/models/conexion.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/request.dart';
import '../models/cliente_ultimo_pago.dart';
import '../controllers/servicios_controller.dart';
import 'dart:convert';

class ClientesController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  //Función obtener todas las Ofertas
  Future<UltimoPago> obtenerUltimosPagos(id) async {
    UltimoPago registro = UltimoPago();
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/conexion/${id}/historial');
      if (jsonDecode(response['data']) != null)
        registro = UltimoPago.fromJson(jsonDecode(response['data']));
    });
    return registro;
  }

  //Función obtener todas las Ofertas
  Future<List<ConexionModel>> getRegistros() async {
    List<ConexionModel> registros = [];
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/conexion/app', params: {"estado" : EstadoConexion.ACTIVO});
      var listado = json.decode(response['data']);
      registros = listado.map<ConexionModel>((registroJson) => ConexionModel.fromJson(registroJson)).toList();
    });
    return registros;
  }

}
