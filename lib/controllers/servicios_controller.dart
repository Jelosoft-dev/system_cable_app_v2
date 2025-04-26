import 'package:tv_cable/models/auth.dart';

import '../models/config_caja.dart';
import '../components/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ServiciosController {
  // ServiciosController();
  String get serveURL => SettingsApp[app_sucursal]!['url'] as String;
  String get reportURL => (SettingsApp[app_sucursal]!['url'] as String) + '/reports/';

  SharedPreferences? sharedPreferences;

  Future<bool> checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getString("token") == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> guardaDatoLogin(Auth user) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('token', user.tokenSession!);
    sharedPreferences!.setString('user', jsonEncode(user));
    return true;
  }

  Future<bool> guardaDetallesCaja(CajaModel cajero) async {
    sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences!.setString('detallesCaja', jsonEncode(cajero));
    return true;
  }

  String rellenarCeros(String valor, int longuitud) {
    String ceros = '';
    if (valor.length == longuitud) {
      return valor;
    } else {
      for (var i = 0; i < (longuitud - valor.length); i++) {
        ceros = ceros + '0';
      }
      return ceros + valor;
    }
  }

  String acortarCadena(String valor, int longuitud) {
    String puntos = '...';
    if (valor.length <= longuitud) {
      return valor;
    } else {
      return valor.substring(0, 10) + puntos;
    }
  }

  Future<bool> cerrarSesion() async {
    sharedPreferences = await SharedPreferences.getInstance();
    bool x = await sharedPreferences!.clear();
    // ignore: deprecated_member_use
    sharedPreferences!.commit();
    return x;
  }

  //function save
  save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = token;
    prefs.setString(key, value);
  }
  

  Future<void> refreshToken(headers) async{
    // Leer el valor del header 'set-cookie'
    final rawCookie = headers['set-cookie'];
    if (rawCookie != null) {
      // Buscar el valor del token
      final token = RegExp(r'token=([^;]+)').firstMatch(rawCookie)?.group(1);
      if (token != null) {
        await save(token);
      } 
    }
  }

  //function read
  Future<dynamic> read() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'token';
    final value = prefs.get(key) ?? 0;
    return value;
  }

  Future<Auth> readUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse = jsonDecode(prefs.getString('user').toString());
    return Auth.fromJson(jsonResponse);
  }

  Future<int?> readIdUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse = jsonDecode(prefs.getString('user').toString());
    Auth user = Auth.fromJson(jsonResponse);
    return user.id;
  }

  Future<String> readNameUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse = jsonDecode(prefs.getString('user').toString());
    Auth user = Auth.fromJson(jsonResponse);
    return user.usuario!;
  }

  Future<int> leerTipoUsuario() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse = jsonDecode(prefs.getString('user').toString());
    Auth user = Auth.fromJson(jsonResponse);
    return user.tipoUsuario!;
  }

  Future< List<Permiso>> obtenerPermisos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> jsonResponse = jsonDecode(prefs.getString('user').toString());
    Auth user = Auth.fromJson(jsonResponse);
    return user.permisos!;
  }

  Future<String> readSerie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String?, dynamic> jsonResponse = jsonDecode(prefs.getString('detallesCaja').toString());
    var cajero = CajaModel.fromJson(jsonResponse);
    return (cajero.configCaja!.serie1! + '-' + cajero.configCaja!.serie2! + '-');
  }

  Future<String> readTimbrado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String?, dynamic> jsonResponse = jsonDecode(prefs.getString('detallesCaja').toString());
    var cajero = CajaModel.fromJson(jsonResponse);
    return (cajero.configCaja!.timbrado!);
  }
}
