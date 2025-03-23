//1 Imports
//2 Lista de Empleados
//3 Stream Controllers
//4 Getter : Stream Sink
//5 Contructor - añadir Data, escuchar camvbios
//6 Funciones Principales
//7 Dispose

import 'dart:async';
import 'package:tv_cable/models/insumo.dart';

import 'package:tv_cable/controllers/insumos_controller.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';

class InsumosBloc {
  InsumosController insumosCtrl = InsumosController();
  ServiciosController servicioCtrl = ServiciosController();
  List<InsumoModel> insumosList = [];
  List<InsumoModel> filterList = [];
  List<InsumoModel> filterList2 = [];
  List<InsumoModel> filterListAux = [];

  bool cargoDatos = false;

  final _insumosListStreamController =
      StreamController<List<InsumoModel>>.broadcast();

  //Getters : Streams y Sinks
  Stream<List<InsumoModel>> get insumosListStream =>
      _insumosListStreamController.stream;
  StreamSink<List<InsumoModel>> get insumosListSink =>
      _insumosListStreamController.sink;

  //Constructor
  InsumosBloc();

  //Funcion Principal
  obtenerRegistros(Map<String, dynamic>? tipo) async {
    cargoDatos = false;
    //Hace la peticion al servidor desde el controlador Oferta
    _insumosListStreamController.add([]);
    insumosList = await insumosCtrl.getRegistros(tipo);
    _insumosListStreamController.add(insumosList);
    filterList = insumosList;
    cargoDatos = true;
  }

  filtrarInsumo(String text) async {
    //Filtra las ofertas por los valores del buscador
    filterList2 = []; //Lista de las Ofertas filtrada
    if (text.isEmpty) {
      //Si es vacio coloca toda las ofertas ya sea si esta clasificada o no
      _insumosListStreamController.add(filterList);
    } else {
      for (var registro in filterList) {
        if (registro.nombre!.contains(text.toUpperCase())) {
          filterList2.add(registro);
        }
      }
      //Actualiza el registro de oferta que a su vez es escuchado por el stream que actualiza la UI
      _insumosListStreamController.add(filterList2);
    }
  }

  //Filtrado principal que luego llama a las funciones de filtrado de Ciudad, Area, Disponibilidad
  filtrarRegistro(String tipo) {
    cargoDatos = false;
    filtrarTipo(tipo);
    cargoDatos = true;
  }

  //Filtra la oferta por Ciudad, recibe como parámetro el ID de la ciudad
  filtrarTipo(String tipo) {
    filterList = insumosList;
    if (tipo != 'null' && tipo != 'T') {
      filterListAux = filterList;
      filterList = [];
      for (var registro in filterListAux) {
        if (registro.tipo.toString() == tipo) {
          filterList.add(registro);
        }
      }
    }
    _insumosListStreamController.add(filterList);
  }

  //Dispose para eliminar los recursos utilizados por los Stream
  void dispose() {
    _insumosListStreamController.close();
  }
}
