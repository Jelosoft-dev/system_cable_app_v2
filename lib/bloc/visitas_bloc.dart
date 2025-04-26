//1 Imports
//2 Lista de Empleados
//3 Stream Controllers
//4 Getter : Stream Sink
//5 Contructor - añadir Data, escuchar camvbios
//6 Funciones Principales
//7 Dispose

import 'dart:async';
import '../controllers/visitas_controller.dart';
import '../controllers/servicios_controller.dart';
import '../models/visita.dart';

class VisitasBloc {
  VisitasController visitasCtrl = VisitasController();
  ServiciosController servicioCtrl = ServiciosController();
  List<Visita> visitasList = [];
  List<Visita> filterList = [];

  bool cargoDatos = false;

  List<dynamic> datosVisita = [];

  final _visitasListStreamController =
      StreamController<List<Visita>>.broadcast();

  //Getters : Streams y Sinks
  Stream<List<Visita>> get visitasListStream =>
      _visitasListStreamController.stream;
  StreamSink<List<Visita>> get visitasListSink =>
      _visitasListStreamController.sink;

  //Constructor
  VisitasBloc();

  Future<bool> save(String id, String estado) {
    return visitasCtrl.saveVisita(id, estado);
  }

  //Funcion Principal
  Future<List<dynamic>> getRegistros() async {
    //Hace la peticion al servidor desde el controlador CLIENTE
    return await visitasCtrl.getRegistros();
  }

  //Funcion Principal
  obtenerRegistros() async {
    cargoDatos = false;
    //Hace la peticion al servidor desde el controlador Oferta
    _visitasListStreamController.add([]);
    visitasList = await visitasCtrl.getRegistros();
    _visitasListStreamController.add(visitasList);
    filterList = visitasList;
    cargoDatos = true;
  }

  void filtrarRegistro(String text){
    //Filtra las ofertas por los valores del buscador
    filterList = []; //Lista de las Ofertas filtrada
    if (text.isEmpty) {
      //Si es vacio coloca toda las ofertas ya sea si esta clasificada o no
      _visitasListStreamController.add(visitasList);
    } else {
      // for (var registro in visitasList) {
      //   if (registro.conexion!.cliente!.razonsocial!.contains(text.toUpperCase())) {
      //     filterList.add(registro);
      //   }
      // }
      List<String> searchWords = text.toUpperCase().split(" ");
      for (var registro in visitasList) {
        // Convertimos razonsocial a mayúsculas y la separamos en palabras
        String razonsocial = registro.conexion!.cliente!.razonsocial!.toUpperCase();
        List<String> razonsocialWords = razonsocial.split(" ");
        // Verificamos si al menos una palabra de búsqueda está en las palabras de la razón social
        bool containsAnyWord = searchWords.every((word) =>
          razonsocialWords.any((razonWord) => razonWord.contains(word))
        );
        if (containsAnyWord) {
          filterList.add(registro);
        }
      }
      //Actualiza el registro de oferta que a su vez es escuchado por el stream que actualiza la UI
      _visitasListStreamController.add(filterList);
    }
  }

  //Dispose para eliminar los recursos utilizados por los Stream
  void dispose() {
    _visitasListStreamController.close();
  }
}
