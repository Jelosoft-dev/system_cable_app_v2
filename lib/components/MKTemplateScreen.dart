import 'package:flutter/material.dart';
import 'package:tv_cable/components/settings.dart'; 
import 'package:tv_cable/components/list_view_drawer.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:flutter/services.dart';
import 'package:tv_cable/models/auth.dart';
import 'package:tv_cable/views/login.dart';


class MKTemplateScreen extends StatefulWidget {
  final Widget body;
  bool drawer;
  final Function(BuildContext)? floatingFunction;
  String floating_tooltip;
  final IconData floating_icon;
  Widget? leading;
  final List<Widget>? actions;
  final String? title;

  MKTemplateScreen({Key? key, 
    required this.body, 
    this.title, 
    this.actions, 
    this.drawer : true, 
    this.leading, 
    this.floating_tooltip : '', 
    this.floating_icon : Icons.search,color,
    this.floatingFunction,
  }) : super(key: key);

  @override
  _MKTemplateScreenState createState() => _MKTemplateScreenState();
}

class _MKTemplateScreenState extends State<MKTemplateScreen> {
  
  ServiciosController serviceCtrl = ServiciosController();

  final SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.light;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  List<Permiso> PERMISOS = []; 
  
  //  VERIFICAR LOGIN
  void checkLoginStatus() async {
    if (await serviceCtrl.checkLoginStatus()) {
      this.PERMISOS = await serviceCtrl.obtenerPermisos();
      setState(() {});
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (BuildContext context) => const LoginPage()),
          (Route<dynamic> route) => false);
    }
  }
  //  FIN VERIFICAR LOGIN

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? SettingsApp[app_sucursal]!['name'] as String,
          style: TextStyle(color: Colors.white),
        ),
        leading: widget.leading,
        centerTitle: true,
        backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
        systemOverlayStyle: _currentStyle,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: widget.actions ?? <Widget>[],
      ),
      backgroundColor: Colors.white,
      body: widget.body, // Aquí se pasa el body recibido como parámetro
      drawer: widget.drawer ? Drawer(
        child: ListViewDrawer(PERMISOS: this.PERMISOS), // Ajusta como sea necesario
      ) : null,
      floatingActionButton : widget.floatingFunction != null ? FloatingActionButton(
        onPressed: () => widget.floatingFunction!(context),
        tooltip: widget.floating_tooltip,
        child: Icon(
          widget.floating_icon,
          color: Colors.white,
        ),
        backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
      ): null, 
    );
  }
}
