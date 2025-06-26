import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/utils/request.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/models/reporte.dart';
import 'package:tv_cable/views/pantalla_view_pdf.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Parametros{
  static Map<String, dynamic>? DESDE_HASTA_DEL_DIA = {
      'desde' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'hasta' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'format' : "pdf",
  };

  static Map<String, dynamic>? DESDE_HASTA_DEL_MES = {
      'desde' : DateFormat('yyyy-MM-dd').format(DateTime(DateTime.now().year,DateTime.now().month, 1)),
      'hasta' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'format' : "pdf",
  };
}

class PantallaReporteList extends StatefulWidget {
  PantallaReporteList({Key? key}) : super(key: key);

  @override
  State<PantallaReporteList> createState() => _PantallaReporteListState();
}

class _PantallaReporteListState extends State<PantallaReporteList> {

  List<Reporte> reporteList = [
    Reporte(
      title : 'Depósito de dinero del día.', 
      fileName : 'Depósito de dinero del día', 
      rptName : '',
      url: 'api/reportes/gerenciales/deposito-de-dinero', 
      params: Parametros.DESDE_HASTA_DEL_DIA),
    Reporte(
      title : 'Depósito de dinero del mes.', 
      fileName : 'Deposito_de_dinero_del_mes', 
      rptName : '',
      url: 'api/reportes/gerenciales/deposito-de-dinero', 
      params: Parametros.DESDE_HASTA_DEL_MES),
    Reporte(
      title : 'Utilidad del día.', 
      fileName : 'Utilidad_del_día.', 
      rptName : '',
      url: 'api/reportes/gerenciales/utilidad', 
      params: Parametros.DESDE_HASTA_DEL_DIA),
    Reporte(
      title : 'Utilidad del mes.', 
      fileName : 'Utilidad_del_mes', 
      rptName : '',
      url: 'api/reportes/gerenciales/utilidad', 
      params: Parametros.DESDE_HASTA_DEL_MES),
    Reporte(
      title : 'Comprobantes emitidos en el día.', 
      fileName : 'Comprobantes_emitidos_en_el_día', 
      rptName : 'Ventas/Factura_Emitidas_PDFReport',
      url: 'api/reportes/ventas/comprobante/emitidos', 
      params: Parametros.DESDE_HASTA_DEL_DIA),
    Reporte(
      title : 'Comprobantes emitidos en el mes.', 
      fileName : 'Comprobantes_emitidos_en_el_mes', 
      url: 'api/reportes/ventas/comprobante/emitidos', 
      rptName : 'Ventas/Factura_Emitidas_PDFReport',
      params: Parametros.DESDE_HASTA_DEL_MES),
  ];

  viewFile(Reporte reporte) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PantallaViewPdf(reporte)),
    );
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
              viewFile(item);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: ListTile(title: DetailText(texto: item.title, fuente: 18.0,),),
            ),
          )
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: 'Lista de Reportes',
      body: _body(),
    );
  }

}
