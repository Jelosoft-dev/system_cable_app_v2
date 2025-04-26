//1 Imports
//2 Lista de Empleados
//3 Stream Controllers
//4 Getter : Stream Sink
//5 Contructor - añadir Data, escuchar camvbios
//6 Funciones Principales
//7 Dispose

import 'dart:async';
import '../controllers/trabajos_controller.dart';
import '../models/trabajo.dart';
import '../models/trabajo_detalle.dart';
import '../models/trabajo_tecnico.dart';
import '../controllers/servicios_controller.dart';

class TrabajosBloc {
  TrabajosController trabajosCtrl = TrabajosController();
  ServiciosController servicioCtrl = ServiciosController();
  List<TrabajoModel> trabajosList = [];
  List<TrabajoModel> filterList = [];
  // Técnicos
  List<TrabajoTecnico> tecnicosList = [];
  List<TrabajoTecnico> filterListTecnico = [];

  List<dynamic> datos = [];

  bool cargoDatos = false;

  final _trabajosListStreamController = StreamController<List<TrabajoModel>>.broadcast();

  //Getters : Streams y Sinks
  Stream<List<TrabajoModel>> get trabajosListStream =>
      _trabajosListStreamController.stream;
  StreamSink<List<TrabajoModel>> get trabajosListSink =>
      _trabajosListStreamController.sink;

  // Técnicos
  final _tecnicosListStreamController =
      StreamController<List<TrabajoTecnico>>.broadcast();

  //Getters : Streams y Sinks
  Stream<List<TrabajoTecnico>> get tecnicosListStream =>
      _tecnicosListStreamController.stream;
  StreamSink<List<TrabajoTecnico>> get tecnicosListSink =>
      _tecnicosListStreamController.sink;


  bool cargoDatosTecnico = false;

  //Constructor
  TrabajosBloc();

  //Guardar nuevo registro
  Future<bool> save(TrabajoModel cabecera, List<TrabajoTecnico> tecnicos, List<TrabajoDetalle> detalles) {
    return trabajosCtrl.saveTrabajo(cabecera, tecnicos, detalles);
  }

  //Funcion Principal
  obtenerRegistros() async {
    cargoDatos = false;
    //Hace la peticion al servidor desde el controlador Oferta
    _trabajosListStreamController.add([]);
    trabajosList = await trabajosCtrl.getRegistros();
    _trabajosListStreamController.add(trabajosList);
    filterList = trabajosList;
    cargoDatos = true;
  }

  //Funcion Principal
  obtenerTecnicos() async {
    cargoDatosTecnico = false;
    // Hace la peticion al servidor desde el controlador Oferta
    _tecnicosListStreamController.add([]);
    tecnicosList = await trabajosCtrl.obtenerTecnicos();
    _tecnicosListStreamController.add(tecnicosList);
    filterListTecnico = tecnicosList;
    cargoDatosTecnico = true;
  }


  void filtrarRegistro(String text) {
    //Filtra las ofertas por los valores del buscador
    filterList = []; //Lista de las Ofertas filtrada
    if (text.isEmpty) {
      //Si es vacio coloca toda las ofertas ya sea si esta clasificada o no
      _trabajosListStreamController.add(trabajosList);
    } else {
      // for (var registro in trabajosList) {
      //   if (registro.conexion!.cliente!.razonsocial!.contains(text.toUpperCase())) {
      //     filterList.add(registro);
      //   }
      // }
      // Convertimos la búsqueda a mayúsculas y la separamos en palabras individuales
      List<String> searchWords = text.toUpperCase().split(" ");
      for (var registro in trabajosList) {
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
      _trabajosListStreamController.add(filterList);
    }
  }
  

  filtrarTecnicos(String text) async {
    //Filtra las ofertas por los valores del buscador
    filterListTecnico = []; //Lista de las Ofertas filtrada
    if (text.isEmpty) {
      //Si es vacio coloca toda las ofertas ya sea si esta clasificada o no
      _tecnicosListStreamController.add(tecnicosList);
    } else {
      for (var registro in tecnicosList) {
        if (registro.razonsocial!.contains(text.toUpperCase())) {
          filterListTecnico.add(registro);
        }
      }
      //Actualiza el registro de oferta que a su vez es escuchado por el stream que actualiza la UI
      _tecnicosListStreamController.add(filterListTecnico);
    }
  }

  //Dispose para eliminar los recursos utilizados por los Stream
  void dispose() {
    _trabajosListStreamController.close();
  }
}
