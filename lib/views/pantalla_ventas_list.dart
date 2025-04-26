import 'dart:io';
import 'package:tv_cable/components/MKCircularProgress.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/components/settings.dart'; 
import 'package:tv_cable/bloc/ventas_bloc.dart';
import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:tv_cable/models/ventas.dart';
import 'package:tv_cable/utils/jasper_report.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';

class PantallaVentasList extends StatefulWidget {
  const PantallaVentasList({Key? key}) : super(key: key);

  @override
  State<PantallaVentasList> createState() => _PantallaVentasListState();
}

class _PantallaVentasListState extends State<PantallaVentasList> {
  ServiciosController serviceCtrl = ServiciosController();
  final VentasBloc _ventasBloc = VentasBloc();
  TextEditingController controller = TextEditingController();
  ServiciosController servicioCtrl = ServiciosController();

  // NumberFormat f = NumberFormat("#,##0", "es_US");
  NumberFormat f = NumberFormat("#,##0", "es_AR");
  int? _loadingPDF = 0;

  Future<void> _actualizar() async {
    await _ventasBloc.obtenerRegistros("");
  }

  onSearchTextChanged(String text){
    _ventasBloc.filtrarRegistro(text);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _actualizar();
  }

  @override
  void dispose() {
    super.dispose();
    _ventasBloc.dispose();
  }

  Future<void> downloadAndOpenPdf(int? id, String tipodoc) async {
    setState(() { _loadingPDF = id!; });
    Map<String, dynamic> params = {
      'id' : id.toString(),
      'rptName' : tipodoc == TipoDocumento.FACTURA ? 'Ventas/Factura_PDFReport' : 'Ventas/Ticket_Cobrador_PDFReport',
    };
    await JasperReport.generar_reporte("api/reportes/ventas/comprobante/factura", "comprobante_${id.toString()}", params: params);
    setState(() { _loadingPDF = 0; });
  }

  Widget _itemBuilder(data, index){
    return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {},
              child: Card(
                child: Column(
                children: <Widget>[
                  ListTile(title: Text(data.conexion!.cliente!.razonsocial ?? '', style: const TextStyle(fontSize: 20.0))),
                  DetailText(texto: 'Total: ' + f.format((data.total ?? '0')), fuente: 15.0),
                  DetailText(texto: 'Tipo Documento: ${data.tipodoc == TipoDocumento.TICKET ? "Ticket" : "Comprobante Legal"}',fuente: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DetailText(texto: (data.fecha != null ? DateFormat('dd/MM/yyyy HH:mm').format(data.fecha) : ''), fuente: 15.0),
                      const Padding(padding: EdgeInsets.only(left: 5.0)),
                      DetailText(texto: 'COD. CONEXIÓN: '+f.format((data.idconexion ?? '0')),fuente: 15.0),
                      const Padding(padding: EdgeInsets.only(left: 0.0)),
                      // if(data.tipodoc == TipoDocumento.TICKET)
                        // ...[
                          (_loadingPDF! > 0 && _loadingPDF == data.id) ? MKCircularProgress()// Cambia al color que desees  
                            :IconButton(
                              onPressed: () {
                                if(_loadingPDF == 0)
                                  downloadAndOpenPdf(data.id, data.tipodoc);
                              },
                              icon: Icon(Icons.print, color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color, size: 28.0),
                            ) 
                        // ]
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 0.0),),
                ],
              )),
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: "Facturas",
      body: MKListView(
        searchController : controller,
        onSearchTextChanged : onSearchTextChanged,
        stream: _ventasBloc.ventasListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
    );
  }
}
