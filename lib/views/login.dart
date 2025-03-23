import 'package:tv_cable/utils/mostrar_alerta.dart';

import '../components/settings.dart';
import '../views/pantalla_inicio.dart';

import '../controllers/servicios_controller.dart';
import '../models/auth.dart';
import '../controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  ServiciosController serviceCtrl = ServiciosController();
  LoginController loginCtrl = LoginController();

  TextEditingController usuarioController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.transparent));
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.indigo.shade50,
              Colors.white,
              // SettingsApp[app_sucursal]!['PrimaryColor'] as Color
          
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  headerSection(),
                  textSection(),
                  const Divider(),
                  buttonSection(),
                ],
              ),
      ),
    );
  }

  Container textSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          TextField(
            controller: usuarioController,
            cursorColor: SettingsApp[app_sucursal]!['PrimaryColor']
                as MaterialColor,
            style: TextStyle(
                color: SettingsApp[app_sucursal]!['PrimaryColor']
                    as MaterialColor,
                fontSize: 18.0),
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle,
                  color: SettingsApp[app_sucursal]!['PrimaryColor']
                      as MaterialColor),
              hintText: 'Usuario',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: SettingsApp[app_sucursal]!['PrimaryColor']
                          as MaterialColor)),
              hintStyle: TextStyle(
                  color: SettingsApp[app_sucursal]!['PrimaryColor']
                      as MaterialColor),
            ),
          ),
          const SizedBox(height: 30.0),
          TextField(
            controller: passwordController,
            cursorColor: SettingsApp[app_sucursal]!['PrimaryColor']
                as MaterialColor,
            obscureText: true,
            style: TextStyle(
                color: SettingsApp[app_sucursal]!['PrimaryColor']
                    as MaterialColor,
                fontSize: 18.0),
            decoration: InputDecoration(
              focusColor: SettingsApp[app_sucursal]!['PrimaryColor']
                  as MaterialColor,
              icon: Icon(Icons.lock,
                  color: SettingsApp[app_sucursal]!['PrimaryColor']
                      as MaterialColor),
              hintText: 'Contraseña',
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: SettingsApp[app_sucursal]!['PrimaryColor']
                          as MaterialColor)),
              hintStyle: TextStyle(
                  color: SettingsApp[app_sucursal]!['PrimaryColor']
                      as MaterialColor),
            ),
          )
        ],
      ),
    );
  }

  Container headerSection() {
    return Container(
      margin: const EdgeInsets.only(top: 30.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Image.asset(
        SettingsApp[app_sucursal]!['logo'] as String,
        width: MediaQuery.of(context).size.width / 3,
        height: MediaQuery.of(context).size.width / 3,
      ),
    );
  }

  signIn(String usuario, pass) async {
    try {
      Auth res = await loginCtrl.iniciarSesion(usuario, pass);
      setState(() => _isLoading = false);
      if (await serviceCtrl.guardaDatoLogin(res)) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const PantallaInicio()),
            (Route<dynamic> route) => false);
      } else {
        mostrarAlerta("Error al guardar los datos de la sesión", "ERROR");
      }
    } catch (e) {
      // ignore: avoid_print
      setState(() => _isLoading = false);
    }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      margin: const EdgeInsets.only(top: 15.0),
      child: ElevatedButton(
        onPressed: () {
          if (usuarioController.text.isEmpty ||
              passwordController.text.isEmpty) {
            Fluttertoast.showToast(
                msg: "Complete los campos.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            setState(() {
              _isLoading = true;
            });
            signIn(usuarioController.text, passwordController.text);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
        child: const Text('Iniciar Sesión',
            style: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }
}
