import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/components/list_view_drawer.dart';
import 'package:tv_cable/constants.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/views/login.dart';
// import 'package:tv_cable/views/pantalla_view_grafic_estado.dart';
// import 'package:tv_cable/views/pantalla_view_grafic_localidad.dart';
// import 'package:tv_cable/views/pantalla_view_grafic_tipo.dart';
import 'package:flutter/material.dart';

class TipoGrafico{
  static const int BARRA_LOCALIDAD = 1;
  static const int BARRA_ESTADO = 2;
  static const int BARRA_TIPO = 3;
}

class Grafico {
  String title;
  int tipo;
  //Contructor
  Grafico(
    this.title, 
    this.tipo, 
  );
}
class PantallaEstadisticaList extends StatefulWidget {
  PantallaEstadisticaList({Key? key}) : super(key: key);

  @override
  State<PantallaEstadisticaList> createState() => _PantallaEstadisticaListState();
}

class _PantallaEstadisticaListState extends State<PantallaEstadisticaList> {

  List<Grafico> reporteList = [
    Grafico('Localidad de conexiones.', TipoGrafico.BARRA_LOCALIDAD),
    Grafico('Estados de conexiones.', TipoGrafico.BARRA_ESTADO),
    Grafico('Tipos de usuarios.', TipoGrafico.BARRA_TIPO),
  ];

  viewGrafic(tipo) {
    switch (tipo) {
      case TipoGrafico.BARRA_LOCALIDAD:
        // Navigator.of(context).push( MaterialPageRoute(builder: (context) => PantallaViewBarGraficLocalidad()),);
        break;
      case TipoGrafico.BARRA_ESTADO:
        // Navigator.of(context).push( MaterialPageRoute(builder: (context) => PantallaViewBarGraficEstado()),);
        break;
      case TipoGrafico.BARRA_TIPO:
        // Navigator.of(context).push( MaterialPageRoute(builder: (context) => PantallaViewBarGraficTipo()), );
        break;
    }
  }

  @override
  initState() {
    super.initState();
  }

  Widget _body(){
    return ListView.builder(
      padding: const EdgeInsets.all(4.0),
      itemCount: reporteList.length,
      itemBuilder: (context, index) {
        var item = reporteList[index];
        return Card(
            elevation: 4.0,
            child: GestureDetector(
              onTap: () {
                viewGrafic(item.tipo);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: ListTile( title: DetailText( texto: item.title, fuente: 18.0,), ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: "Lista de Reportes",
      body: _body(),
    );
  }

}
