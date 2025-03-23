import 'package:tv_cable/bloc/users_bloc.dart';
import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKModalConfirm.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/models/conexion.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/bloc/clientes_bloc.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/models/cliente_ultimo_pago.dart';
import 'package:tv_cable/views/pantalla_insumos_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PantallaClientesList extends StatefulWidget {
  const PantallaClientesList({Key? key}) : super(key: key);

  @override
  State<PantallaClientesList> createState() => _PantallaClientesListState();
}

class _PantallaClientesListState extends State<PantallaClientesList> {
  ServiciosController serviceCtrl = ServiciosController();
  final ClientesBloc _clientesBloc = ClientesBloc();
  final UsersBloc _userBloc = UsersBloc();
  TextEditingController controller = TextEditingController();

  ConexionModel _clienteFacturar = ConexionModel();
  UltimoPago _ultimoPago = UltimoPago();
  NumberFormat f = NumberFormat("#,##0", "es_AR");

  Future<void> _actualizar() async {
    await _clientesBloc.obtenerRegistros();
  }

  Future<void> _obtenerDetallesCaja() async {
    int? idUser = await serviceCtrl.readIdUser();
    bool guardado_exitoso = await _userBloc.obtenerDetallesCaja(idUser!.toString());
    if(!guardado_exitoso){
      mostrarAlerta("No se pudo guardar los detalles de la caja", "ERROR");
    }
  }

  onSearchTextChanged(String text) async {
    await _clientesBloc.filtrarRegistro(text);
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _actualizar();
    _obtenerDetallesCaja();
  }

  void pedirConfirmacion(BuildContext context, String titulo) async {
    bool? resultado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModalConfirm(
          titulo: titulo,
        );
      },
    );

    if (resultado != null && resultado) {
      setearCliente();
    } 
  }
  
  void setearCliente() async {  
    if(_clienteFacturar.estado != EstadoConexion.CORTE){
      _ultimoPago = await _clientesBloc.obtenerUltimosPagos(_clienteFacturar.id);

      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PantallaInsumosList(_clienteFacturar, _ultimoPago), ),
      );
    }else{
      mostrarAlerta("El cliente tiene un estado INACTIVO", "ERROR");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _clientesBloc.dispose();
  }

  Widget _itemBuilder(data, index){
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {},
          child: Card(
              child: Column(
            children: <Widget>[
              ListTile(title: Text(data.cliente.razonsocial ?? '', style: const TextStyle(fontSize: 20.0), ),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  DetailText( texto: 'CUOTA: ' +f.format(data.cuota) +' gs.', fuente: 12.0),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  DetailText(texto: 'DEUDA: ' + f.format(data.deudaAnterior) +' gs.', fuente: 12.0),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  DetailText(texto: 'LOCALIDAD: ' + (data.localidad.nombre ?? 'N/A'), fuente: 15.0),
                  const Padding(padding: EdgeInsets.only(left: 15)),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0,bottom: 8.0,),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    child: const Icon(Icons.person_add, color: Colors.green,size: 38, ),
                    onTap: () {
                      _clienteFacturar = data;
                      pedirConfirmacion(context, "¿Realizar una facturación a este Cliente?");
                    },
                  ),
                ),
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
      title: 'Lista de Clientes',
      body: MKListView(
        onSearchTextChanged : onSearchTextChanged,
        stream: _clientesBloc.clientesListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
    );
  }

}
