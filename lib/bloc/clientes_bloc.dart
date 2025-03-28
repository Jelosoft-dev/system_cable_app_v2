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

  filtrarRegistro(String text) async {
    //Filtra las ofertas por los valores del buscador
    filterList = []; //Lista de las Ofertas filtrada
    if (text.isEmpty) {
      //Si es vacio coloca toda las ofertas ya sea si esta clasificada o no
      _clientesListStreamController.add(clientesList);
    } else {
      // Dividir por espacio en blanco
      for (var registro in clientesList) {
        if (registro.cliente!.razonsocial!.toUpperCase().contains(text.toUpperCase())) {
          filterList.add(registro);
        }
      }
      //Actualiza el registro de oferta que a su vez es escuchado por el stream que actualiza la UI
      _clientesListStreamController.add(filterList);
    }
  }

  //Dispose para eliminar los recursos utilizados por los Stream
  void dispose() {
    _clientesListStreamController.close();
  }
}
