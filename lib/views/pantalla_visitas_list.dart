import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/components/MKModalConfirm.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';

import '../bloc/visitas_bloc.dart';
import '../components/input_detail_text.dart';
import '../controllers/servicios_controller.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class PantallaVisitaList extends StatefulWidget {
  PantallaVisitaList({Key? key}) : super(key: key);

  @override
  State<PantallaVisitaList> createState() => _PantallaVisitaListState();
}

class _PantallaVisitaListState extends State<PantallaVisitaList> {
  ServiciosController serviceCtrl = ServiciosController();
  final VisitasBloc _visitasBloc = VisitasBloc();
  TextEditingController controller = TextEditingController();

  NumberFormat f = NumberFormat("#,##0", "es_US");

  Future<void> _actualizar() async {
    await _visitasBloc.obtenerRegistros();
    setState(() {});
  }

  onSearchTextChanged(String text) async {
    await _visitasBloc.filtrarRegistro(text);
    setState(() {});
  }

  void mostrarDialogo(BuildContext context, String? id, String titulo, String estado) async {
    bool? resultado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModalConfirm(
          titulo: titulo,
        );
      },
    );

    if (resultado != null && resultado) {
      guardarVisita(id!, estado);
    } 
  }


  void guardarVisita(String id, String estado) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => MKLoader(),
    );

    bool res = await _visitasBloc.save(id, estado);

    Navigator.of(context, rootNavigator: true).pop(context);
    if (res) {
      _actualizar();
    } 
  }

  @override
  void initState() {
    super.initState();
    _actualizar();
  }

  @override
  void dispose() {
    super.dispose();
    _visitasBloc.dispose();
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
                title: Text(data.conexion!.cliente!.razonsocial ?? '',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  DetailText(
                      texto: 'DEUDA: ' +f.format(data.deuda)+' gs.',
                      fuente: 12.0),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0, bottom: 8.0, ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.attach_money_outlined,
                          color: Colors.green,
                          size: 30,
                        ),
                        onTap: () {
                          mostrarDialogo(context, data.id, '¿Registrar como pagado?', 'PA' );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 8.0,),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.signal_wifi_off_sharp,
                          color: Colors.red,
                          size: 30,
                        ),
                        onTap: () {
                          mostrarDialogo(context, data.id,'¿Registrar como corte?', 'CO');
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  DetailText(
                      texto: 'LOCALDIAD: '+(data.conexion!.localidad!.nombre ?? ''),
                      fuente: 12.0),
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
      body: MKListView(
        searchController : controller,
        onSearchTextChanged : onSearchTextChanged,
        stream: _visitasBloc.visitasListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
    );
  }
}
