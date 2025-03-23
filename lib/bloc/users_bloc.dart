//1 Imports
//2 Lista de Empleados
//3 Stream Controllers
//4 Getter : Stream Sink
//5 Contructor - añadir Data, escuchar camvbios
//6 Funciones Principales
//7 Dispose

import 'dart:async';
import 'package:tv_cable/models/config_caja.dart';

import '../controllers/user_controller.dart';
// import '../models/trabajo_tecnico.dart';
import '../controllers/servicios_controller.dart';

class UsersBloc {
  UserController usersCtrl = UserController();
  ServiciosController servicioCtrl = ServiciosController();

  //Constructor
  UsersBloc();

  Future<bool> obtenerDetallesCaja(String idUser) async {
    CajaModel detallesCaja = await usersCtrl.obtenerDetallesCaja(idUser);
    bool guardado_exitoso = await servicioCtrl.guardaDetallesCaja(detallesCaja);
    return guardado_exitoso;
  }

  
}
