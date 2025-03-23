import 'package:tv_cable/components/mensajes.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/utils/request.dart';

import '../models/trabajo.dart';
import '../models/trabajo_detalle.dart';
import '../models/trabajo_tecnico.dart';
import '../controllers/servicios_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// permission_handler: '^4.4.0+hotfix.2'
//   downloads_path_provider_28:
//   dio:
//   open_file:
//   flutter_local_notifications:
//   path_provider:

class TrabajosController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  //Función obtener todas las Ofertas
  Future<List<TrabajoModel>> getRegistros() async {
    List<TrabajoModel> registros = [];
      await alertException(() async {
        var response = await request("GET", serveURL, 'api/trabajo/pendientes');
        var listado = json.decode(response['data']);
        registros = listado.map<TrabajoModel>((registroJson) => TrabajoModel.fromJson(registroJson)).toList();
      });
      return registros;
  }

  //Función obtener todos los Funcionarios
  Future<List<TrabajoTecnico>> obtenerTecnicos() async {
    List<TrabajoTecnico> registros = [];
      await alertException(() async {
        var response = await request("GET", serveURL, 'api/funcionario/selectable-list');
        var listado = json.decode(response['data']);
        registros = listado.map<TrabajoTecnico>((registroJson) => TrabajoTecnico.fromJson(registroJson)).toList();
      });
      return registros;
  }

  //function for register products
  Future<bool> saveTrabajo(TrabajoModel cabecera, List<TrabajoTecnico> tecnicos, List<TrabajoDetalle> detalles) async {
      await alertException(() async {
        cabecera.detalles = detalles;
        cabecera.tecnicos = tecnicos;
        var body = jsonEncode(cabecera.toJson());
        print('body');
        print(body);
        var response = await request("PUT", serveURL, 'api/trabajo/app/${cabecera.id.toString()}', body:body, headers: {'Content-Type': 'application/json',});
        mostrarAlerta(MensajeABM['INSERTADO']!, 'SUCCESS');
      });
      return true;
  }
}
