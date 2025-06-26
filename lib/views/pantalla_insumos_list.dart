// ignore_for_file: unnecessary_new

import 'package:tv_cable/components/MKInputNumber.dart';
import 'package:tv_cable/components/MKListView.dart';
import 'package:tv_cable/components/MKModal.dart';
import 'package:tv_cable/components/MKModalConfirm.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/settings.dart';
import 'package:tv_cable/models/conexion.dart';
import 'package:tv_cable/models/cliente_ultimo_pago.dart';
import 'package:tv_cable/models/insumo.dart';
import 'package:tv_cable/models/venta_detalle.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';

import '../bloc/insumos_bloc.dart';
import '../components/input_detail_text.dart';
import '../controllers/servicios_controller.dart';
import '../views/carrito.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetallesPago{
  static int DEUDA_PENDIENTE = 0;
  static DateTime? FECHA_ULTIMO_PAGO= null;
  static bool ES_PRIMER_PAGO = false;
  static int DEUDA_MES_PENDIENTE = 0;
  static int DEUDA_MES_PENDIENTE_AUX = 0;
  static String ULTIMO_PAGO = 'S/P';
  static int CUOTA_CLIENTE = 0;
}

class PantallaInsumosList extends StatefulWidget {
  final ConexionModel _conexion;
  final UltimoPago _ultimoPago;
  const PantallaInsumosList(
      this._conexion, 
      this._ultimoPago, 
      {Key? key})
      : super(key: key);

  @override
  State<PantallaInsumosList> createState() =>
      // ignore: no_logic_in_create_state
      _PantallaInsumosListState(_conexion, _ultimoPago);
}

class _PantallaInsumosListState extends State<PantallaInsumosList> {
  _PantallaInsumosListState(this._conexion, this._ultimoPago);
  ServiciosController serviceCtrl = ServiciosController();
  final InsumosBloc _insumosBloc = InsumosBloc();
  TextEditingController controller = TextEditingController();

  final ConexionModel _conexion;
  final UltimoPago _ultimoPago;
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _anhoController = TextEditingController();
  final List<VentaDetalleModel> _listaCarro = [];
  InsumoModel _detalleInsumo = InsumoModel();

  NumberFormat f = NumberFormat("#,##0", "es_AR");
  NumberFormat f2 = NumberFormat("#,##0.0#", "es_AR");

  DateFormat inputFormat = DateFormat('yyyy-MM-dd');
  DateFormat outputFormat = DateFormat('dd/MM/yyyy');

  /** INICIO DE SETEO DE VARIABLES GLOBALES */
  DateTime? _fecha_ultimo_pago_actual;
  DateTime? _fecha_pago_sgte;
  int _AnhoPago = DateTime.now().year;
  /** FIN DE SETEO DE VARIABLES GLOBALES */


  void setear_cliente(ConexionModel Conexion_Data) async {
    /**********************OBTENER ULTIMO PAGO************************ */ 
    DateTime? fecha_ultimo_pago;
    bool es_primer_pago = false;
    if(_conexion.ultimoPago == null){
        fecha_ultimo_pago = DateTime(_conexion.primerPago!.year, _conexion.primerPago!.month, 1);
        es_primer_pago = true;
    }else{
        fecha_ultimo_pago = DateTime(_conexion.ultimoPago!.year, _conexion.ultimoPago!.month, 1);
        _conexion.primerPago = DateTime(_conexion.primerPago!.year, _conexion.primerPago!.month, 1);
        if(_conexion.primerPago!.compareTo(fecha_ultimo_pago) > 0){
          fecha_ultimo_pago = DateTime(_conexion.primerPago!.year, _conexion.primerPago!.month, 1);
          es_primer_pago = true;
        }
    }

    int deuda_mes_pendiente = 0;
    if(_ultimoPago.mes != null && _ultimoPago.mes! > 0){
        deuda_mes_pendiente = _ultimoPago.deuda ?? 0;
        if(DateTime(_ultimoPago.anho!, _ultimoPago.mes!, 1).compareTo(fecha_ultimo_pago) > 0){
            fecha_ultimo_pago = DateTime(_ultimoPago.anho!, _ultimoPago.mes!, 1);
        }
    }
    /**********************FIN OBTENER ULTIMO PAGO************************ */ 
    _fecha_ultimo_pago_actual = fecha_ultimo_pago;

    DateTime fecha_pago_sgte = DateTime(_fecha_ultimo_pago_actual!.year, _fecha_ultimo_pago_actual!.month, _fecha_ultimo_pago_actual!.day);
    if(deuda_mes_pendiente == 0 && !es_primer_pago){
        _fecha_pago_sgte = sumarMes(DateTime(fecha_pago_sgte.year, fecha_pago_sgte.month, fecha_pago_sgte.day), 1);
    }else{
        _fecha_pago_sgte = fecha_pago_sgte;
        if(es_primer_pago){
          deuda_mes_pendiente = 0;
        }
    }
    DetallesPago.DEUDA_PENDIENTE = Conexion_Data.deudaAnterior ?? 0;
    DetallesPago.FECHA_ULTIMO_PAGO = fecha_ultimo_pago;
    DetallesPago.ES_PRIMER_PAGO = es_primer_pago;
    DetallesPago.DEUDA_MES_PENDIENTE = deuda_mes_pendiente;
    DetallesPago.DEUDA_MES_PENDIENTE_AUX = deuda_mes_pendiente;
    DetallesPago.ULTIMO_PAGO = DateFormat('dd/MM/yyyy').format(fecha_ultimo_pago);
    DetallesPago.CUOTA_CLIENTE = Conexion_Data.cuota ?? 0;
  }

  @override
  initState() {
    super.initState();
    setear_cliente(_conexion);
    _actualizar();
  }

  DateTime sumarMes(DateTime date, int mes) {
    return DateTime(date.year, date.month + mes, date.day);
  }

  Future<void> _actualizar() async {
    await _insumosBloc.obtenerRegistros(null);
  }

  onSearchTextChanged(String text) {
    _insumosBloc.filtrarInsumo(text);
    setState(() {});
  }


  Widget botonesDelFiltro(String texto, Map<String, dynamic>? tipo){
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          textStyle: const TextStyle(color: Colors.white),
          backgroundColor: SettingsApp[app_sucursal]!['PrimaryLightColor'] as Color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0),),
        ),
        onPressed: () {
          _insumosBloc.obtenerRegistros(tipo);
          Navigator.of(context, rootNavigator: true).pop(context);
        },
        icon: const Icon(Icons.filter, color: Colors.white,),
        label: Text(texto, style: TextStyle(color: Colors.white),),
      ),
    );
  }
  
  Widget filtrosContent(){
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        botonesDelFiltro("Materiales", {"tipo" : TipoInsumo.ARTICULO}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        botonesDelFiltro("Materiales", {"tipo" : TipoInsumo.SERVICIO}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        botonesDelFiltro("Mensualidades", {"tipo" : TipoInsumo.MENSUALIDAD}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        botonesDelFiltro("Todo", null),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
  }

  void filtrosDialog(BuildContext context) async {
    await showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(child: Text('Filtrar Lista por:')),
          content: filtrosContent(),
        );
      },
    );
  }

  Widget viewClienteContent(){
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DetailText( texto: 'LOCALIDAD: ' + _conexion.localidad!.nombre!, fuente: 15.0, ),
          DetailText( texto: 'Tipo de cliente: '+ConexionModel.TipoConexion(_conexion.tipo!), fuente: 15.0, ),
          DetailText( texto: 'DEUDA ANTERIOR DE: ' + f.format(DetallesPago.DEUDA_PENDIENTE), fuente: 15.0, ),
          DetailText( texto: (DetallesPago.ES_PRIMER_PAGO ? 'PRIMER PAGO: ' : 'ÚLTIMO PAGO: ') + DetallesPago.ULTIMO_PAGO, fuente: 15.0, ),
          DetailText( texto: 'PENDIENTE POR EL MES: ' + f.format(DetallesPago.DEUDA_MES_PENDIENTE), fuente: 15.0, ),
          DetailText( texto: 'CUOTA: ' + f.format(DetallesPago.CUOTA_CLIENTE), fuente: 15.0, ),
        ],
      );
  }

  void viewCliente() async{
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModal(
          titulo: _conexion.cliente!.razonsocial!,
          content: viewClienteContent(),
        );
      },
    );
  }

  void asignarArticulo() {
    // Si es mensualidad validar que se este pagando por esta fecha y sumar 1 mes más a setFechaPagoSgte
    // int precio = _detalleInsumo.id! < 13 ? DetallesPago.CUOTA_CLIENTE : _detalleInsumo.precio_min!;
    int precio = _detalleInsumo.precio_min!;

    if(_detalleInsumo.tipo == TipoInsumo.MENSUALIDAD){
      if(_fecha_pago_sgte == null){
        mostrarAlerta("No se tiene un valor en la próxima fecha a pagar.", "ERROR");
        return;
      }
      DateTime fecha_a_cargar_en_detalle = DateTime.now();
      try {
        fecha_a_cargar_en_detalle = DateTime(_AnhoPago, int.parse(DateFormat('MM').format(_detalleInsumo.desde!)), 1);
      } catch (e) {
        mostrarAlerta('El año de pago no es un año válido', 'ERROR');
        return;
      }
      
      if(_fecha_pago_sgte!.compareTo(fecha_a_cargar_en_detalle) != 0){
          mostrarAlerta('No es posible pagar por esta fecha. La fecha que debe pagar es por ${DateFormat('MM/yyyy').format(_fecha_pago_sgte!)}', 'ERROR');
          return;
      }
                                          
      if(_detalleInsumo.id! < 13 && _fecha_ultimo_pago_actual!.compareTo(_fecha_pago_sgte!) == 0 && DetallesPago.DEUDA_MES_PENDIENTE > 0 && !DetallesPago.ES_PRIMER_PAGO ){
          mostrarAlerta('Error: No puede pagar un pago completo por que el cliente tiene un pago parcial registrado con una deuda pendiente de ${f.format(DetallesPago.DEUDA_MES_PENDIENTE)} ₲.', 'ERROR');
          return;
      }else if(_fecha_ultimo_pago_actual!.compareTo(_fecha_pago_sgte!) == 0 && DetallesPago.DEUDA_MES_PENDIENTE > 0){
          precio = _detalleInsumo.precio_min!;
          // precio = DetallesPago.DEUDA_MES_PENDIENTE;
          DetallesPago.DEUDA_MES_PENDIENTE = DetallesPago.DEUDA_MES_PENDIENTE - precio;
      }
      if(DetallesPago.DEUDA_MES_PENDIENTE == 0)
        _fecha_pago_sgte = sumarMes(DateTime(_fecha_pago_sgte!.year, _fecha_pago_sgte!.month, _fecha_pago_sgte!.day), 1); 
    } 

    if(double.parse(_detalleInsumo.stock!) > 0 || _detalleInsumo.tipo != TipoInsumo.ARTICULO){
      double cantidad = double.parse(_detalleInsumo.stock!) < 1 && _detalleInsumo.tipo == TipoInsumo.ARTICULO ? double.parse(_detalleInsumo.stock!) : 1;
      VentaDetalleModel detalle = VentaDetalleModel();
      detalle.idinsumo = _detalleInsumo.id;
      detalle.descripcion = _detalleInsumo.nombre;
      detalle.mes_pago = _detalleInsumo.desde == null ? null : int.parse(DateFormat('MM').format(_detalleInsumo.desde!));
      detalle.anho_pago = _AnhoPago;
      detalle.cantidad = cantidad;
      detalle.idiva = _detalleInsumo.idiva;
      detalle.stock = double.parse(_detalleInsumo.stock ?? '0');
      detalle.costo = _detalleInsumo.costopp;
      detalle.precio = precio;
      detalle.tipo = _detalleInsumo.tipo;
      detalle.subtotal = (precio * cantidad).round();
      detalle.parcial = false;
      _listaCarro.add(detalle);
      setState(() { });
    }else{
      mostrarAlerta('Stock no disponible. Stock actual ${_detalleInsumo.stock} ${_detalleInsumo.unidadMedida?.descripcion}', 'ERROR');
    }
  }

  void modalAnhoPago() async{
    _anhoController.text = f.format(_AnhoPago);

     bool? resultado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModal(
          titulo: "Año de pago",
          content: MKInputNumber(
            controller: _anhoController,
            onChanged:  (value) {
              _AnhoPago = int.parse(value != '' ? value.replaceAll('.', '') : '0');
            },
            icon: Icons.date_range,
            validator: MKInputNumberValidator.REQUERIDO
          ),
        );
      },
    );
    
    if (resultado != null && resultado) {
      if(TipoInsumo.ID_PAGO_PARCIAL.indexWhere((item) => item == _detalleInsumo.id) >= 0){
        modalPrecioAPagar(DetallesPago.DEUDA_MES_PENDIENTE);
      }else{
        modalPrecioAPagar(DetallesPago.CUOTA_CLIENTE);
      }
    } 
  }

  void modalPrecioAPagar(int? precio) async{
    _precioController.text = f.format(precio);
    _detalleInsumo.precio_min = precio;

     bool? resultado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModal(
          titulo: "Fije el precio",
          content: MKInputNumber(
            controller: _precioController,
            icon: Icons.price_change,
            onChanged:  (value) {
              _detalleInsumo.precio_min = int.parse(_precioController.text != '' ? _precioController.text.replaceAll('.', '') : '0');
            }
          ),
        );
      },
    );
    
    if(resultado != null && resultado == true){
      if(validarPrecio()){
        asignarArticulo();
      }else{
        modalPrecioAPagar(precio);
      }
    }
  }

  bool validarPrecio(){
    if(_detalleInsumo.precio_min == null || _detalleInsumo.precio_min! <= 0){
      mostrarAlerta("El precio no es válido.", "ERROR");
      return false;
    }else if(_detalleInsumo.id == TipoInsumo.DEUDA_PENDIENTE){
      if(DetallesPago.DEUDA_PENDIENTE == 0){
        mostrarAlerta("Este cliente no tiene deudas con esta conexión.", "ERROR");
        return false;
      }else if(_detalleInsumo.precio_min! > DetallesPago.DEUDA_PENDIENTE){
        mostrarAlerta("El precio no debe ser superior a la deuda de ${f.format(DetallesPago.DEUDA_PENDIENTE)}", "ERROR");
        return false;
      }
    }else if(TipoInsumo.ID_PAGO_PARCIAL.indexWhere((item) => item == _detalleInsumo.id) >= 0){
      if(DetallesPago.DEUDA_MES_PENDIENTE != 0 && _detalleInsumo.precio_min! > DetallesPago.DEUDA_MES_PENDIENTE){
        mostrarAlerta("El precio no debe ser superior al monto restante por la mensualidad del Cliente. El monto pendiente es de ${f.format(DetallesPago.DEUDA_MES_PENDIENTE)}", "ERROR");
        return false;
      }else if(DetallesPago.DEUDA_MES_PENDIENTE == 0 && _detalleInsumo.precio_min! >= DetallesPago.CUOTA_CLIENTE){
        mostrarAlerta("El precio no debe ser superior o igual al monto de la cuota del Cliente. La cuota es de ${f.format(DetallesPago.CUOTA_CLIENTE)}", "ERROR");
        return false;
      } 
    } 
    return true;
  }

  bool contiene(int id) {
    return _listaCarro.any((car) => car.idinsumo == id);
  }

  void remover(int id) {
    int index = obtenerIndexDelDetalle(id);
    if(index == -1){
      mostrarAlerta("Detalle no encontrado", "ERROR");
      return;
    }
    
    VentaDetalleModel item_a_eliminar = _listaCarro[index];
    DateTime? ultimo_pago;
    int index_ultimo_pago = -1;
    if(TipoInsumo.ID_PAGOS.indexWhere((item) => item == item_a_eliminar.idinsumo!) >= 0){
        // Obtener último pago de mensualidad en el detalle
        for (var i = 0; i < _listaCarro.length; i++) {
            VentaDetalleModel detail = _listaCarro[i];
            if(TipoInsumo.ID_PAGOS.indexWhere((item) => item == detail.idinsumo!) >= 0){
              ultimo_pago = DateTime(detail.anho_pago!, detail.mes_pago!, 1);
              index_ultimo_pago = i;
            }
        }
        if(index != index_ultimo_pago){
          mostrarAlerta('No es posible quitar este detalle por que el último pago del detalle es ${DateFormat('MM/yyyy').format(ultimo_pago!)}.', 'ERROR');
          return;
        }
    }

    _listaCarro.removeAt(index);
    ultimo_pago = DateTime(_fecha_ultimo_pago_actual!.year, _fecha_ultimo_pago_actual!.month, 1);
    for (var i = 0; i < _listaCarro.length; i++) {
        VentaDetalleModel detail = _listaCarro[i];
        if(TipoInsumo.ID_PAGOS.indexWhere((item) => item == detail.idinsumo!) >= 0){
          ultimo_pago = DateTime(detail.anho_pago!, detail.mes_pago!, 1);
        }
    }

    bool tiene_pago_en_detalle = _listaCarro.any((detail) => 
      TipoInsumo.ID_PAGOS.contains(detail.idinsumo)
    );


    if(!tiene_pago_en_detalle && (DetallesPago.DEUDA_MES_PENDIENTE > 0 || DetallesPago.ES_PRIMER_PAGO)){
        _fecha_pago_sgte = DateTime(ultimo_pago!.year, ultimo_pago.month, 1);
        DetallesPago.DEUDA_MES_PENDIENTE = DetallesPago.DEUDA_MES_PENDIENTE_AUX;
    }else{
        _fecha_pago_sgte = sumarMes(DateTime(ultimo_pago!.year, ultimo_pago.month, 1), 1);
    }
  }

  int obtenerIndexDelDetalle(int id){
    for (var i = 0; i < _listaCarro.length; i++) {
      if(id == _listaCarro[i].idinsumo){
        return i;
      }
    }
    return -1;
  }

  bool comprobarRegPago() {
    return _listaCarro.any((item) => item.tipo == "M");
  }

  @override
  void dispose() {
    super.dispose();
    _insumosBloc.dispose();
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
                title: Text(data.nombre ?? '', style: const TextStyle(fontSize: 20.0),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.only(left: 15)),
                  DetailText(texto: 'PRECIO: ' + f.format(data.precio_min) + ' gs.', fuente: 15.0),
                  const Padding(padding: EdgeInsets.only(left: 5)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  DetailText(texto: 'STOCK: ' + f2.format(double.parse(data.stock ??'0')),fuente: 15.0),
                  Padding( padding: const EdgeInsets.only(left: 15, right: 8.0,bottom: 8.0,),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: Icon(
                                Icons.shopping_cart,
                                color: contiene(data.id) ? Colors.red : Colors.green, 
                                size: 28,
                              ),
                        onTap: () {
                          setState(() {
                            if (!contiene(data.id)) {
                              _detalleInsumo = data;
                              setState(() {});
                              if(data.tipo == TipoInsumo.MENSUALIDAD){
                                modalAnhoPago();
                              }else if(data.id == TipoInsumo.DEUDA_PENDIENTE){
                                modalPrecioAPagar(DetallesPago.DEUDA_PENDIENTE);
                              }else if(data.tipo ==  TipoInsumo.SERVICIO){
                                modalPrecioAPagar(data.precio_min);
                              }else{
                                asignarArticulo();
                              }
                            } else {
                              remover(data.id);
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
              if (_listaCarro.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(left: 2.0),
                  child: CircleAvatar(
                    radius: 8.0,
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    child: Text(
                      _listaCarro.length.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0),
                    ),
                  ),
                ),
            ],
          ),
          onTap: () {
            if (_listaCarro.isNotEmpty) {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => PaginaCarrito(_conexion, _listaCarro), ),
              );
            }
          },
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: 'Lista de Items',
      actions: _actions(),
      drawer : false,
      floatingFunction: filtrosDialog,
      floating_tooltip : 'Filtrar',
      body: MKListView(
        searchController : controller,
        onSearchTextChanged : onSearchTextChanged,
        stream: _insumosBloc.insumosListStream, 
        onRefresh: _actualizar, 
        contenido: _itemBuilder,
      ),
    );
  }

}
