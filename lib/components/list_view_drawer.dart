import 'package:tv_cable/controllers/login_controller.dart';
import 'package:tv_cable/models/auth.dart';
import 'package:tv_cable/views/pantalla_trabajo_list.dart';
import 'package:tv_cable/views/pantalla_ventas_list.dart';
import 'package:tv_cable/views/pantalla_ventas_my_list.dart';
import 'package:tv_cable/views/pantalla_visitas_list.dart';
import 'package:tv_cable/views/pantalla_clientes_list.dart';

import 'settings.dart';
import '../views/about.dart';
import '../views/login.dart';
//import '../views/pantalla_estadistica_list.dart';
import '../views/pantalla_reporte_list.dart';

import 'package:flutter/material.dart';

class ListViewDrawer extends StatelessWidget {

  // Declarar un array de strings
  final List<Permiso> PERMISOS; 

  const ListViewDrawer({
    Key? key,
    required this.PERMISOS,
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            '',
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          accountEmail: Text(
            '',
            style: TextStyle(fontSize: 16.0, color: Colors.black87),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [SettingsApp[app_sucursal]!['PrimaryColor'] as Color, Colors.white10],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                scale: 10, // Reduce la imagen (ajusta el valor según sea necesario)
                image: AssetImage(SettingsApp[app_sucursal]!['logo'] as String),
              )),
        ),
        const Divider(),
        if(PERMISOS.any((permiso) => permiso.descripcion == 'MENU_VISITA'))
          ListTile(
            title: const Text(
              'Visitas',
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: const Icon(Icons.add_business_rounded),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => PantallaVisitaList(),
            )),
          ),
        if(PERMISOS.any((permiso) => permiso.descripcion == 'MENU_FACTURACION'))
          ListTile(
            title: const Text(
              'Facturación',
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: const Icon(Icons.article_rounded),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const PantallaClientesList(),
            )),
          ),
        if(PERMISOS.any((permiso) => permiso.descripcion == 'MENU_FACTURACION'))
          ListTile(
            title: const Text(
              'Facturas',
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: const Icon(Icons.print),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const PantallaVentasList(),
            )),
          ),
        if(PERMISOS.any((permiso) => permiso.descripcion == 'MENU_FACTURACION'))
          ListTile(
            title: const Text(
              'Mis Facturas',
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: const Icon(Icons.print),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const PantallaVentasMyList(),
            )),
          ),
        if(PERMISOS.any((permiso) => permiso.descripcion == 'MENU_FACTURACION'))
          ListTile(
            title: const Text(
              'Trabajos',
              style: TextStyle(fontSize: 16.0),
            ),
            trailing: const Icon(Icons.construction),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => const PantallaTrabajosList(),
            )),
          ),
        if(PERMISOS.any((permiso) => permiso.descripcion == 'MENU_FACTURACION'))
        ListTile(
          title: const Text(
            'Reportes',
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: const Icon(Icons.picture_as_pdf),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => PantallaReporteList(),
          )),
        ),
        // ListTile(
        //   title: const Text(
        //     'Estadísticas',
        //     style: TextStyle(fontSize: 16.0),
        //   ),
        //   trailing: const Icon(Icons.pie_chart),
        //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
        //     builder: (BuildContext context) => PantallaEstadisticaList(),
        //   )),
        // ),
        const Divider(),
        ListTile(
          title: const Text(
            'Acerca de',
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: const Icon(Icons.book),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const AboutPage(),
          )),
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Cerrar Sesión',
            style: TextStyle(fontSize: 16.0),
          ),
          trailing: const Icon(Icons.logout),
          onTap: () async {
            LoginController loginCtrl = LoginController();
            bool response = await loginCtrl.cerrarSesion();
            if (response) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
            }
          },
        ),
      ],
    );
  }
}
