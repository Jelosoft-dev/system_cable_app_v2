//1 Imports
//2 Lista de Empleados
//3 Stream Controllers
//4 Getter : Stream Sink
//5 Contructor - añadir Data, escuchar camvbios
//6 Funciones Principales
//7 Dispose

import 'dart:async';
import 'package:tv_cable/models/cliente_ultimo_pago.dart';
import 'package:tv_cable/models/conexion.dart';
import '../controllers/clientes_controller.dart';
import '../controllers/servicios_controller.dart';

class ClientesBloc {
  ClientesController clientesCtrl = ClientesController();
  ServiciosController servicioCtrl = ServiciosController();
  List<ConexionModel> clientesList = [];
  List<ConexionModel> filterList = [];

  bool cargoDatos = false;

  List<dynamic> datosCliente = [];

  final _clientesListStreamController =
      StreamController<List<ConexionModel>>.broadcast();

  //Getters : Streams y Sinks
  Stream<List<ConexionModel>> get clientesListStream =>
      _clientesListStreamController.stream;
  StreamSink<List<ConexionModel>> get clientesListSink =>
      _clientesListStreamController.sink;

  //Constructor
  ClientesBloc();

  //Funcion Principal
  Future<UltimoPago> obtenerUltimosPagos(id) async {
    //Hace la peticion al servidor desde el controlador CLIENTE
    return await clientesCtrl.obtenerUltimosPagos(id);
  }

  //Funcion Principal
  obtenerRegistros() async {
    cargoDatos = false;
    //Hace la peticion al servidor desde el controlador Oferta
    _clientesListStreamController.add([]);
    clientesList = await clientesCtrl.getRegistros();
    _clientesListStreamController.add(clientesList);
    filterList = clientesList;
    cargoDatos = true;
  }

  void filtrarRegistro(String text) {
    filterList = []; // Reiniciamos la lista filtrada

    if (text.isEmpty) {
      // Si el texto está vacío, mostramos la lista completa
      _clientesListStreamController.add(clientesList);
    } else {
      // Convertimos la búsqueda a mayúsculas y la separamos en palabras individuales
      List<String> searchWords = text.toUpperCase().split(" ");

      for (var registro in clientesList) {
        // Convertimos razonsocial a mayúsculas y la separamos en palabras
        String razonsocial = registro.cliente!.razonsocial!.toUpperCase().trim();
        List<String> razonsocialWords = razonsocial.split(" ");

        // Verificamos si **todas** las palabras de búsqueda están en la razón social (sin importar el orden)
        bool containsAllWords = searchWords.every((word) =>
          razonsocialWords.any((razonWord) => razonWord.contains(word))
        );

        if (containsAllWords) {
          filterList.add(registro);
        }
      }

      // Actualizamos la lista filtrada en el stream
      _clientesListStreamController.add(filterList);

    }
  }


  //Dispose para eliminar los recursos utilizados por los Stream
  void dispose() {
    _clientesListStreamController.close();
  }
}
