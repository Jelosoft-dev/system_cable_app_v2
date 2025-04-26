import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/settings.dart';
import 'package:tv_cable/utils/jasper_report.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/bloc/trabajos_bloc.dart';
import 'package:tv_cable/views/pantalla_trabajo_detalle.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';

class PantallaTrabajosList extends StatefulWidget {
  const PantallaTrabajosList({Key? key}) : super(key: key);

  @override
  State<PantallaTrabajosList> createState() => _PantallaTrabajosListState();
}

class _PantallaTrabajosListState extends State<PantallaTrabajosList> {
  ServiciosController servicioCtrl = ServiciosController();
  final TrabajosBloc _trabajosBloc = TrabajosBloc();
  TextEditingController controller = TextEditingController();

  NumberFormat f = NumberFormat("#,##0", "es_US");
  NumberFormat format_py = NumberFormat("#,##0", "es_AR");

  Future<void> _actualizar() async {
    await _trabajosBloc.obtenerRegistros();
  }

  onSearchTextChanged(String text) {
    _trabajosBloc.filtrarRegistro(text);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _trabajosBloc.obtenerRegistros();
  }

  @override
  void dispose() {
    super.dispose();
    _trabajosBloc.dispose();
  }

  Future<void> downloadAndOpenPdf(int? id) async {
    Map<String, dynamic> params = {
      'id' : id.toString(),
      'rptName' : 'Trabajo/TicketTrabajoCobradorPDFReport',
    };
    await JasperReport.generar_reporte("api/reportes/trabajos/ticket", "trabajo_${id.toString()}", params: params);
  }
  

  Widget _itemBuilder(data, index){
    return Container(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => PantallaTrabajoDetalle(data)));
              },
              child: Card(
                child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(data.conexion!.cliente!.razonsocial, style: const TextStyle(fontSize: 20.0)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DetailText( texto: (data.fecha_recep != null ? DateFormat('dd/MM/yyyy HH:mm').format(data.fecha_recep) : ''), fuente: 15.0),
                      const Padding(padding: EdgeInsets.only(left: 5.0)),
                      DetailText( texto: 'COD.: '+format_py.format(data.id ?? 0), fuente: 15.0),
                      const Padding(padding: EdgeInsets.only(left: 0.0)),
                      IconButton(
                        onPressed: () {
                          downloadAndOpenPdf(data.id);
                        },
                        icon: Icon( Icons.print, color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color, size: 28.0,),
                      )
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
      title: "Lista de Trabajos",
      body: MKListView(
        searchController : controller,
        onSearchTextChanged : onSearchTextChanged,
        stream: _trabajosBloc.trabajosListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
    );
  }
}
