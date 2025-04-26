//1 Imports
//2 Lista de Empleados
//3 Stream Controllers
//4 Getter : Stream Sink
//5 Contructor - añadir Data, escuchar camvbios
//6 Funciones Principales
//7 Dispose

import 'dart:async';
import 'package:tv_cable/models/venta_detalle.dart';
import '../models/ventas.dart';
import '../controllers/ventas_controller.dart';
import '../controllers/servicios_controller.dart';

class VentasBloc {
  VentasController ventasCtrl = VentasController();
  ServiciosController servicioCtrl = ServiciosController();
  List<VentaModel> ventasList = [];
  List<VentaModel> filterList = [];

  List<dynamic> datos = [];

  bool cargoDatos = false;

  final _ventasListStreamController =
      StreamController<List<VentaModel>>.broadcast();

  //Getters : Streams y Sinks
  Stream<List<VentaModel>> get ventasListStream =>
      _ventasListStreamController.stream;
  StreamSink<List<VentaModel>> get ventasListSink =>
      _ventasListStreamController.sink;

  //Constructor
  VentasBloc();

  //Guardar nuevo registro
  Future<VentaModel> save(VentaModel cabecera, List<VentaDetalleModel> detalles) {
    return ventasCtrl.saveVenta(cabecera, detalles);
  }

  //Funcion Principal
  obtenerRegistros(String id) async {
    cargoDatos = false;
    //Hace la peticion al servidor desde el controlador Oferta
    _ventasListStreamController.add([]);
    ventasList = await ventasCtrl.getRegistros(id);
    _ventasListStreamController.add(ventasList);
    filterList = ventasList;
    cargoDatos = true;
  }

  void filtrarRegistro(String text) {
    //Filtra las ofertas por los valores del buscador
    filterList = []; //Lista de las Ofertas filtrada
    if (text.isEmpty) {
      //Si es vacio coloca toda las ofertas ya sea si esta clasificada o no
      _ventasListStreamController.add(ventasList);
    } else {
      // for (var registro in ventasList) {
      //   if (registro.conexion!.cliente!.razonsocial!.contains(text.toUpperCase())) {
      //     filterList.add(registro);
      //   }
      // }
      List<String> searchWords = text.toUpperCase().split(" ");
      for (var registro in ventasList) {
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
      _ventasListStreamController.add(filterList);
    }
  }

  //Dispose para eliminar los recursos utilizados por los Stream
  void dispose() {
    _ventasListStreamController.close();
  }
}
