import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../controllers/servicios_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

// import 'package:cookies/cookies.dart'; // Suponiendo que estás usando un paquete para cookies

dynamic mostrarAlerta(String mensaje, String tipo) {
  const TipoAlerta = {
    'ERROR' : Colors.red,
    'SUCCESS' : Colors.green,
    'WARNING' : Colors.yellow,
  };

  Fluttertoast.showToast(
      msg: mensaje,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: TipoAlerta[tipo],
      textColor: Colors.white,
      fontSize: 16.0);
}
