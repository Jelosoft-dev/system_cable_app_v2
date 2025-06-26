import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:tv_cable/utils/request.dart';
import './mostrar_alerta.dart';
import '../controllers/servicios_controller.dart';
import 'package:http/http.dart' as http;
import 'package:open_file/open_file.dart';

class JasperReport{
  static ServiciosController serviciosCtrl = ServiciosController();

  static Future<void> generar_reporte(String path, String fileName, {String format = "pdf", Map<String, dynamic>? params, Map<String, String>? headers}) async {
    try {

      headers = headers != null
        ? {
            ...headers,
            'Authorization': 'Token  ${(await serviciosCtrl.read()).toString()}'
          }
        : {'Authorization': 'Token  ${(await serviciosCtrl.read()).toString()}'};

      // Si params es null, inicializarlo como un nuevo mapa
      params ??= {};
      // Agregar el formato al mapa de parámetros
      params["format"] = format;

      // Descargar el PDF
      final response = await http.get(UrlRequest.UriURL(path, params : params),headers: headers,);      
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        // Obtener el directorio temporal
        final dir = await getTemporaryDirectory();
        // Crear un archivo temporal
        final file = File('${dir.path}/${fileName}.${format}');
        // Escribir los bytes en el archivo
        await file.writeAsBytes(bytes, flush: true);
        // Abrir el archivo PDF
        await OpenFile.open(file.path);
      } else {
        print('Error al descargar el PDF: ${response.statusCode}');
        mostrarAlerta('Error al descargar el PDF. Error: ${response.statusCode}', "ERROR");
      }
    } catch (e) {
      mostrarAlerta('Error al obtener el archivo PDF.', "ERROR");
      print('Error al descargar el PDF: $e');
    }
  }

  

  static Future<String> view_reporte(String path, String fileName, String rptName, {String format = "pdf", Map<String, dynamic>? params, Map<String, String>? headers}) async {
    try {

      headers = headers != null
        ? {
            ...headers,
            'Authorization': 'Token  ${(await serviciosCtrl.read()).toString()}'
          }
        : {'Authorization': 'Token  ${(await serviciosCtrl.read()).toString()}'};

      // Si params es null, inicializarlo como un nuevo mapa
      params ??= {};
      // Agregar el formato al mapa de parámetros
      params["format"] = format;
      params["rptName"] = rptName;

      // Descargar el PDF
      final response = await http.get(UrlRequest.UriURL(path, params : params),headers: headers,);      
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        // Obtener el directorio temporal
        final dir = await getTemporaryDirectory();
        // Crear un archivo temporal
        final file = File('${dir.path}/${fileName}.${format}');
        // Escribir los bytes en el archivo
        await file.writeAsBytes(bytes, flush: true);
        // Abrir el archivo PDF
        return file.path;
      } else {
        print('Error al descargar el PDF: ${response.statusCode}');
        mostrarAlerta('Error al descargar el PDF. Error: ${response.statusCode}', "ERROR");
      }
    } catch (e) {
      mostrarAlerta('Error al obtener el archivo PDF.', "ERROR");
      print('Error al descargar el PDF: $e');
    }
    return "";
  }

}
