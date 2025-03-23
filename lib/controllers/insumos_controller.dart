import 'package:tv_cable/models/insumo.dart';
import 'package:tv_cable/utils/alertException.dart';
import 'package:tv_cable/utils/request.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'dart:convert';

class InsumosController {
  static ServiciosController serviciosCtrl = ServiciosController();

  String serveURL = serviciosCtrl.serveURL;

  //Función obtener todas las Ofertas
  Future<List<InsumoModel>> getRegistros(Map<String, dynamic>? tipo) async {
    List<InsumoModel> registros = [];
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/articulo/tipo', params: tipo);//?tipo=${tipo.toString()}
      var listado = json.decode(response['data']);
      registros = listado.map<InsumoModel>((registroJson) => InsumoModel.fromJson(registroJson)).toList();
    });
    return registros;
  }

  //Función obtener todas las Ofertas
  Future<List<InsumoModel>> getInsumos(String tipo) async {
    List<InsumoModel> registros = [];
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/articulo/tipo?tipo=${tipo}');
      var listado = json.decode(response['data']);
      registros = listado.map<InsumoModel>((registroJson) => InsumoModel.fromJson(registroJson)).toList();
    });
    return registros;
  }

  //Función obtener todas las Ofertas
  Future<List<InsumoModel>> getServicios(String tipo) async {
    List<InsumoModel> registros = [];
    await alertException(() async {
      var response = await request("GET", serveURL, 'api/articulo/tipo?tipo=${tipo}');
      var listado = json.decode(response['data']);
      registros = listado.map<InsumoModel>((registroJson) => InsumoModel.fromJson(registroJson)).toList();
    });
    return registros;
  }
}
