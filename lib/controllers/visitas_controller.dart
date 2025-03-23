import 'package:tv_cable/components/mensajes.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/utils/request.dart';

import 'package:tv_cable/models/visita.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'dart:convert';

class VisitasController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  //Función obtener todos los registros
  Future<List<Visita>> getRegistros() async {
      List<Visita> registros = [];
      await alertException(() async {
        var response = await request("GET", serveURL, 'api/visita');
        var listado = json.decode(response['data']);
        registros = listado.map<Visita>((registroJson) => Visita.fromJson(registroJson)).toList();
      });
      return registros;
  }

  //function for register products
  Future<bool> saveVisita(String id, String estado) async {
      await alertException(() async {
        var body = {
          'estado': estado,
        };
        var response = await request("PUT", serveURL, 'api/visita/${id}', body:body);
        mostrarAlerta(MensajeABM['INSERTADO']!, 'SUCCESS');
      });
      return true;
  }
}
