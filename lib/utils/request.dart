import 'dart:convert';

import 'package:http/http.dart' as http;
import '../controllers/servicios_controller.dart';

// import 'package:cookies/cookies.dart'; // Suponiendo que estás usando un paquete para cookies

class HTTP{
  static String GET = "GET";
  static String POST = "POST";
  static String PUT = "PUT";
  static String DELETE = "DELETE";
}

class UrlRequest{
  static Uri UriURL(String path, {String host = "", Map<String, dynamic>? params = null}){
    ServiciosController serviciosCtrl = ServiciosController();
    return Uri.http(host == "" ? serviciosCtrl.serveURL : host, path, params);
  }

  static String StringURL(String path, {String host = "", Map<String, dynamic>? params = null}){
    ServiciosController serviciosCtrl = ServiciosController();
    return Uri.http(host == "" ? serviciosCtrl.serveURL : host, path, params).toString();
  }

  static Future<Map<String, String>> Headers() async{
    ServiciosController serviciosCtrl = ServiciosController();
    return {'Authorization': 'Token  ${(await serviciosCtrl.read()).toString()}'};
  }
}

dynamic checkStatus(response) {
  String mensaje = "";
  dynamic data = null;

  if (response is http.Response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }
    print('response.body checkStatus '+response.statusCode.toString());
    print(jsonEncode(response.body));
    data = jsonDecode(response.body); // Suponiendo que response.body es un JSON
  } else if (response is http.ClientException) {
    mensaje = response.message;
  }


  if (data != null && data.containsKey("mensaje")) {
    if (data["mensaje"] is List) {
      mensaje = data["mensaje"][0];
    } else if (data["mensaje"] is String) {
      mensaje = data["mensaje"];
    }
  } else if (data.containsKey("error")) {
    if (data["error"] is List) {
      mensaje = data["error"][0]["message"];
    }
  }

  if (data["mostrar_mensaje"]) {
    mensaje = data["mensaje"];
    switch (response.statusCode) {
      case 401:
        // Aquí puedes manejar la lógica específica de 401, por ejemplo, eliminar cookies
        // Cookies.remove("token");
        break;
    }
  } else {
    switch (response.statusCode) {
      case 401:
        mensaje =
            "Sesión expirada"; // Podrías tener un map de constantes con mensajes
        break;
      case 403:
        mensaje = "Sesión expirada";
        break;
      default:
        mensaje = "Error genérico";
        break;
    }
  }

  if (!data["mostrar_mensaje"]) {
    print(data);
  }

  throw Exception(mensaje);
}

Future<Map<String, dynamic>> request(String method, String host, String path, {Map<String, dynamic>? params = null, body = null, Map<String, String>? headers}) async {
    var response;
    ServiciosController serviciosCtrl = ServiciosController();

    headers = headers != null
        ? {
            ...headers,
            ...await UrlRequest.Headers(),
          }
        : await UrlRequest.Headers();


    switch (method.toUpperCase()) {
      case "GET":
        response = await http.get(UrlRequest.UriURL(path, params : params),headers: headers,);
        break;
      case "POST":
        response = await http.post(UrlRequest.UriURL(path, params : params), body: body, headers: headers, );
        break;
      case "PUT":
        response = await http.put(UrlRequest.UriURL(path, params : params), body: body, headers: headers, );
        break;
      case "DELETE":
        response = await http.delete(UrlRequest.UriURL(path, params : params), body: body, headers: headers, );
        break;
    }

    checkStatus(response);
    // Aquí obtienes el cuerpo de la respuesta
    final data = response.body;
    serviciosCtrl.refreshToken(response.headers);
    return {
      'data': data,
      'headers': {}, // Puedes añadir encabezados si es necesario
    };
}
