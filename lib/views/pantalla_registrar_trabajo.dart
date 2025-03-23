import 'package:tv_cable/components/MKEmpty.dart';
import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';

import '../bloc/trabajos_bloc.dart';
import '../constants.dart';
import '../controllers/servicios_controller.dart';
import '../models/trabajo.dart';
import '../models/trabajo_detalle.dart';
import '../models/trabajo_tecnico.dart';
import '../views/pantalla_trabajo_list.dart';
import 'package:flutter/material.dart';

class PantallaRegistrarTrabajo extends StatefulWidget {
  final TrabajoModel cabecera;
  final List<TrabajoTecnico> listTecnico;
  final List<TrabajoDetalle> listDetalle;
  PantallaRegistrarTrabajo(this.cabecera, this.listTecnico, this.listDetalle, {Key? key}) : super(key: key);

  @override
  State<PantallaRegistrarTrabajo> createState() => _PantallaRegistrarTrabajoState(cabecera, listTecnico, listDetalle);
}

class _PantallaRegistrarTrabajoState extends State<PantallaRegistrarTrabajo> {
  _PantallaRegistrarTrabajoState(this.cabecera, this.listTecnico, this.listDetalle);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  final bool _enabled = false;

  final TrabajoModel cabecera;
  final List<TrabajoTecnico> listTecnico;
  final List<TrabajoDetalle> listDetalle;

  ServiciosController servicioCtrl = ServiciosController();
  TrabajosBloc trabajoBloc = TrabajosBloc();

  void guardarTrabajo() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => MKLoader());

    bool res = await trabajoBloc.save(cabecera, listTecnico, listDetalle);

    Navigator.of(context, rootNavigator: true).pop(context);
    if (res) {
      Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const PantallaTrabajosList()),
            (Route<dynamic> route) => false
          );
      });
    }
  }

  _addProduct(int index) {
    num total = listDetalle[index].cantidad ?? 0;
    setState(() {
      if (listDetalle[index].tipo == 'I') {
        listDetalle[index].cantidad = int.parse(total.toString()) + 1;
      }
    });
  }

  _removeProduct(int index) {
    num total = listDetalle[index].cantidad ?? 0;
    setState(() {
      if (listDetalle[index].cantidad != '1') {
        listDetalle[index].cantidad = int.parse(total.toString()) - 1;
      }
    });
  }

  
  List<Widget> _actions(){
    return <Widget>[
            IconButton( 
              icon: Icon(Icons.list_alt, color: Colors.white,),
              onPressed: null,
              color: Colors.white,
            )
          ];
  }

  Widget _leading(){
    return IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              listDetalle.length;
            });
          },
          color: Colors.white,
        );
  }

  Widget _bodyDetail(item, index){
    return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                child: Column(
                  children: <Widget>[
                    Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(item.nombre!, style: const TextStyle(fontSize: 20.0)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.red[600],
                                    boxShadow: [
                                      BoxShadow(blurRadius: 6.0, color: Colors.blue, offset: Offset(0.0, 1.0))
                                    ],
                                    borderRadius: const BorderRadius.all(Radius.circular(50.0))
                                  ),
                                margin: const EdgeInsets.only(top: 20.0),
                                padding: const EdgeInsets.all(0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    const SizedBox(height: 8.0,),
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () {
                                        _removeProduct(index);
                                      },
                                      color: Colors.yellow,
                                    ),
                                    Text('${listDetalle[index].cantidad}',
                                    style: const TextStyle(fontWeight:FontWeight.bold, fontSize: 18.0, color: Colors.white)),
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        _addProduct(index);
                                      },
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(height: 8.0,)
                                  ],
                                ),
                              )
                            ],
                          ),
                          const Padding(padding:EdgeInsets.only(bottom: 10))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(color: Colors.purple, )
            ],
          );
  }
  
  Widget _body(){
    return GestureDetector(
          onVerticalDragUpdate: (details) {
            if (_enabled && _firstScroll) {
              _scrollController.jumpTo(_scrollController.position.pixels - details.delta.dy);
            }
          },
          onVerticalDragEnd: (_) {
            if (_enabled) _firstScroll = false;
          },
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              listDetalle.isEmpty
                  ? MKEmpty()
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: listDetalle.length,
                      itemBuilder: (context, index) {
                        var item = listDetalle[index];
                        if (listDetalle[index].cantidad == null) {
                          listDetalle[index].cantidad = 1;
                        }
                        return _bodyDetail(item, index);
                      },
                    ),
              const SizedBox(
                width: 10.0,
              ),
              const SizedBox(
                width: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(fontSize: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    guardarTrabajo();
                  },
                  child: const Text('Guardar'),
                ),
              ),
            ],
          )));
  }

  
  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: "Guardar Trabajo",
      actions: _actions(),
      leading: _leading(),
      body:  _body(),
      drawer: false,
    );
  }
  

}
