import 'package:tv_cable/bloc/trabajos_bloc.dart';
import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/models/trabajo.dart';
import 'package:tv_cable/models/trabajo_tecnico.dart';
import 'package:tv_cable/views/pantalla_trabajo_insumos.dart';
import 'package:flutter/material.dart';

class PantallaTecnicoTrabajo extends StatefulWidget {
  final TrabajoModel cabecera;
  PantallaTecnicoTrabajo(this.cabecera, {Key? key}) : super(key: key);

  @override
  State<PantallaTecnicoTrabajo> createState() =>
      _PantallaTecnicoTrabajoState(cabecera);
}

class _PantallaTecnicoTrabajoState extends State<PantallaTecnicoTrabajo> {
  _PantallaTecnicoTrabajoState(this.cabecera);
  final TrabajoModel cabecera;

  List<TrabajoTecnico> listTecnico = [];

  ServiciosController serviceCtrl = ServiciosController();
  final TrabajosBloc _trabajoBloc = TrabajosBloc();
  TextEditingController controller = TextEditingController();

  Future<void> _actualizar() async {
    await _trabajoBloc.obtenerTecnicos();
  }

  onSearchTextChanged(String text) async {
    await _trabajoBloc.filtrarTecnicos(text);
    setState(() {});
  }

  bool contiene(int id) {
    return listTecnico.any((tecnico) => tecnico.idtecnico == id);
  }

  void remover(int id) {
    listTecnico.removeWhere((tecnico) => tecnico.idtecnico == id);
  }

  @override
  initState() {
    super.initState();
    _trabajoBloc.obtenerTecnicos();
  }

  @override
  void dispose() {
    super.dispose();
    _trabajoBloc.dispose();
  }

  List<Widget> _actions(){
    return <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 16.0, top: 8.0),
              child: GestureDetector(
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: <Widget>[
                    const Icon(Icons.person, size: 38, ),
                    if (listTecnico.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: CircleAvatar(
                          radius: 8.0,
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          child: Text(
                            listTecnico.length.toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0),
                          ),
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (listTecnico.isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => PantallaTrabajoInsumo(cabecera, listTecnico)));
                  }
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
                      title: Text(data.razonsocial ?? '', style: const TextStyle(fontSize: 20.0)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 15, right: 8.0,bottom: 8.0,),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: GestureDetector(
                              child: Icon(
                                contiene(data.idtecnico) ? Icons.person_remove : Icons.person_add,
                                color: contiene(data.idtecnico) ? Colors.red : Colors.green,
                                size: 28,
                              ),
                              onTap: () {
                                setState(() {
                                  if (contiene(data.idtecnico)) {
                                    remover(data.idtecnico);
                                  } else {
                                    listTecnico.add(TrabajoTecnico(null, data.idtecnico, this.cabecera.id));
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5.0)),
                  ],
                )),
              ),
            );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: "Lista de Técnicos",
      actions: _actions(),
      body:  MKListView(
        onSearchTextChanged : onSearchTextChanged,
        stream: _trabajoBloc.tecnicosListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
      drawer: false,
    );
  }
}
