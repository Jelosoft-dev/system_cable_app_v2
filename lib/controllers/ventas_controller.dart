import 'package:tv_cable/components/mensajes.dart';
import 'package:tv_cable/models/venta_detalle.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/utils/request.dart';
import 'package:tv_cable/models/ventas.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'dart:convert';

// permission_handler: '^4.4.0+hotfix.2'
//   downloads_path_provider_28:
//   dio:
//   open_file:
//   flutter_local_notifications:
//   path_provider:

class VentasController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  //Función obtener todas las Ofertas
  Future<List<VentaModel>> getRegistros(String id) async {
    List<VentaModel> registros = [];
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/venta', params: {"idcajero" : id});
      var listado = json.decode(response['data']);
      registros = listado.map<VentaModel>((registroJson) => VentaModel.fromJson(registroJson)).toList();
    });
    return registros;
  }

  //function for register products
  Future<VentaModel> saveVenta(VentaModel cabecera, List<VentaDetalleModel> detalles) async {
    VentaModel instancia = VentaModel();
    await alertException(() async {
      cabecera.detalles = detalles;
      var body = jsonEncode(cabecera.toJson());
      print('body');
      print(body);
      var response = await request(HTTP.POST, serveURL, 'api/venta', body:body, headers: {'Content-Type': 'application/json',});
      if (jsonDecode(response['data']) != null)
        instancia = VentaModel.fromJson(jsonDecode(response['data']));
      mostrarAlerta(MensajeABM['INSERTADO']!, 'SUCCESS');
    });
    return instancia;
    
  }
}
