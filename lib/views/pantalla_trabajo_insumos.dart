import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/settings.dart';
import 'package:tv_cable/models/insumo.dart';

import 'package:tv_cable/bloc/insumos_bloc.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/constants.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/models/trabajo.dart';
import 'package:tv_cable/models/trabajo_detalle.dart';
import 'package:tv_cable/models/trabajo_tecnico.dart';
import 'package:tv_cable/views/login.dart';
import 'package:tv_cable/views/pantalla_registrar_trabajo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class PantallaTrabajoInsumo extends StatefulWidget {
  final TrabajoModel cabecera;
  final List<TrabajoTecnico> listTecnico;

  PantallaTrabajoInsumo(this.cabecera, this.listTecnico, {Key? key}) : super(key: key);

  @override
  State<PantallaTrabajoInsumo> createState() => _PantallaTrabajoInsumoState(cabecera, listTecnico);
}

class _PantallaTrabajoInsumoState extends State<PantallaTrabajoInsumo> {
  _PantallaTrabajoInsumoState(this.cabecera, this.listTecnico);

  ServiciosController serviceCtrl = ServiciosController();
  final InsumosBloc _insumosBloc = InsumosBloc();
  TextEditingController controller = TextEditingController();

  NumberFormat f = NumberFormat("#,##0", "es_AR");
  NumberFormat f2 = NumberFormat("#,##0.0#", "es_AR");

  final TrabajoModel cabecera;
  final List<TrabajoTecnico> listTecnico;
  final List<TrabajoDetalle> listDetalle = [];

  Future<void> _actualizar() async {
    await _insumosBloc.obtenerRegistros({'tipo':'IS'});
  }

  onSearchTextChanged(String text) {
    _insumosBloc.filtrarInsumo(text);
    setState(() {});
  }

  String obtenerTipo(String param) {
    switch (param) {
      case 'C':
        return 'NUEVA CONEXIÓN';
      case 'M':
        return 'MANTENIMIENTO';
      case 'I':
        return 'CORTE';
      case 'R':
        return 'RECONEXIÓN';
      default:
        return param;
    }
  }

  bool contiene(int id) {
    return listDetalle.any((tecnico) => tecnico.idinsumo == id);
  }

  void remover(int id) {
    listDetalle.removeWhere((tecnico) => tecnico.idinsumo == id);
  }
  
  void viewCliente() {
    AlertDialog alertDialog = AlertDialog(
      title: Text(cabecera.conexion!.cliente!.razonsocial!),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DetailText(texto: 'C.I. / RUC: ' + cabecera.conexion!.cliente!.ciruc!.toString(), fuente: 15.0,),
          DetailText(texto: 'TELÉFONO: ' + cabecera.conexion!.cliente!.telefono!, fuente: 15.0,),
          Text('TIPO: ' + obtenerTipo(cabecera.tipo!),style: TextStyle(fontSize: 15.0),),
          DetailText(
            texto: 'INICIO: ' + (cabecera.fecha_realizada != null ? DateFormat('dd/MM/yyyy HH:mm').format(cabecera.fecha_realizada!) : ''),
            fuente: 15.0,
          ),
          DetailText(
            texto: 'FIN: ' + (cabecera.fecha_finalizada != null ? DateFormat('dd/MM/yyyy HH:mm').format(cabecera.fecha_finalizada!) : ''),
            fuente: 15.0,
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: const Text("Aceptar", style: TextStyle(color: Colors.white, fontSize: 18.0,)),
          style: ElevatedButton.styleFrom(
            backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
            elevation: 0.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop(context);
          },
        ),
      ],
    );

    showDialog(context: context, builder: (context) => alertDialog);
  }

  @override
  initState() {
    _insumosBloc.obtenerRegistros({'tipo':'I'});
    super.initState();
  }

  List<Widget> _actions(){
    return <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: const <Widget>[
                    Icon(Icons.person,size: 38,),
                  ],
                ),
                onTap: () {
                  viewCliente();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    const Icon(Icons.shopping_cart, size: 38, ),
                    if (listDetalle.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            listDetalle.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PantallaRegistrarTrabajo(cabecera, listTecnico, listDetalle),),
                  );
                },
              ),
            )
          ];
  }

  Widget _itemBuilder(data, index){
    return Container(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {},
            child: Card(
                child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(data.nombre ?? '',style: const TextStyle(fontSize: 20.0)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding( padding: EdgeInsets.only(left: 15)),
                    DetailText(texto: 'P. MIN.: ' +f.format(data.precio_min ?? 0)+' gs.', fuente: 15.0),
                    const Padding(padding:EdgeInsets.only(left: 5)),
                    DetailText(texto: 'P. MAY.: ' + f.format(data.precio_max ?? 0) +' gs.', fuente: 15.0),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.only(left: 10)),
                    DetailText(texto: 'STOCK: ' +f2.format(double.parse(data.stock ?? '0')), fuente: 15.0),
                    Padding(padding: const EdgeInsets.only(left: 15, right: 8.0,bottom: 8.0,),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          child: Icon(
                              Icons.shopping_cart,
                              color: contiene(data.id) ? Colors.red : Colors.green,
                              size: 28,),
                          onTap: () {
                            setState(() {
                              if (contiene(data.id)) {
                                remover(data.id);
                              } else {
                                listDetalle.add(TrabajoDetalle(null, this.cabecera.id, data.id, data.nombre, data.tipo, 1, data.costo, data.costo));
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 5.0),),
              ],
            )),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: "Lista de Items",
      actions: _actions(),
      body:  MKListView(
        searchController : controller,
        onSearchTextChanged : onSearchTextChanged,
        stream: _insumosBloc.insumosListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
      drawer: false,
    );
  }
  
}
