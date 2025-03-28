import 'package:tv_cable/components/MKInputNumber.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/components/MKModal.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/settings.dart';
import 'package:tv_cable/models/conexion.dart';
import 'package:tv_cable/models/insumo.dart';
import 'package:tv_cable/models/iva.dart';
import 'package:tv_cable/models/venta_detalle.dart';
import 'package:tv_cable/models/ventas.dart';
import 'package:tv_cable/utils/jasper_report.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/utils/simbolo.dart';

import 'package:tv_cable/bloc/ventas_bloc.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/views/pantalla_clientes_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaginaCarrito extends StatefulWidget {
  final ConexionModel _cliente;
  final List<VentaDetalleModel> _cart;
  const PaginaCarrito(this._cliente, this._cart, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<PaginaCarrito> createState() => _PaginaCarritoState(_cliente, _cart);
}

class _PaginaCarritoState extends State<PaginaCarrito> {
  _PaginaCarritoState(this._conexion, this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  final bool _enabled = false;

  final VentasBloc _ventasBloc = VentasBloc();

  ServiciosController servicioCtrl = ServiciosController();

  final VentaModel cabecera = VentaModel();

  final TextEditingController _efectivoController = TextEditingController();
  final TextEditingController _chequeController = TextEditingController();
  final TextEditingController _valeController = TextEditingController();
  final TextEditingController _tarjetaController = TextEditingController();
  final TextEditingController _totalController = TextEditingController();
  final TextEditingController _vueltoController = TextEditingController();
  final TextEditingController _FacturaController = TextEditingController();
  final TextEditingController _TimbradoController = TextEditingController();

  int totalVenta = 0;
  int totalCobrar = 0;
  int vuelto = 0;
  int totale = 0;
  int total5 = 0;
  int total10 = 0;

  NumberFormat f = NumberFormat("#,##0", "es_AR");

  final List<VentaDetalleModel> _cart;
  final ConexionModel _conexion;

  ///** ESTA SECCIÓN ES PARA ABRIR EL PDF DE LA FACTURA*/
  Future<void> downloadAndOpenPdf(int? id, String tipodoc) async {
    Map<String, dynamic> params = {
      'id' : id.toString(),
      'rptName' : 'Ventas/Ticket_Cobrador_PDFReport',
    };
    await JasperReport.generar_reporte("api/reportes/ventas/comprobante/factura", "comprobante_${id.toString()}", params: params);
  }
  ///**FIN SECCIÓN ES PARA ABRIR EL PDF DE LA FACTURA */

  void guardarFactura() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => MKLoader());

    int? iduser = await servicioCtrl.readIdUser();
    cabecera.idcajero = iduser!;
    cabecera.idconexion = _conexion.id;
    cabecera.tipo_conexion = _conexion.tipo;

    // Cobros al cliente
    cabecera.efectivo = int.parse(_efectivoController.text.replaceAll(".", ""));
    cabecera.vale = int.parse(_valeController.text.replaceAll(".", ""));
    cabecera.cheque = int.parse(_chequeController.text.replaceAll(".", ""));
    cabecera.tarjeta = int.parse(_tarjetaController.text.replaceAll(".", ""));
    // Fin Cobros al cliente

    cabecera.reconexion = false;
    cabecera.condicion = CondicionVenta.CONTADO;
    cabecera.estado = EstadoVenta.ACTIVO;
    cabecera.num_fact_cobrador = _FacturaController.text;
    cabecera.timbrado = _TimbradoController.text;

    cabecera.tipodoc = TipoDocumento.TICKET;

    cabecera.orden_reconexion = false;
    cabecera.primer_pago = null;
    cabecera.cuota = _conexion.cuota;

    VentaModel instancia = await _ventasBloc.save(cabecera, _cart);
    
    Future.delayed(const Duration(milliseconds: 1), () {
      Navigator.of(context, rootNavigator: true).pop(context);
    });

    if (instancia.id != null && instancia.id! > 0) {
      // openFile( url: servicioCtrl.reportURL +  "newTicketCobradorpdf.php?idventa=" + instancia.id.toString(), fileName: 'factura.pdf');
      await downloadAndOpenPdf(instancia.id, instancia.tipodoc!);
      Future.delayed(const Duration(milliseconds: 1500), () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (BuildContext context) => const PantallaClientesList()),
            (Route<dynamic> route) => false);
      });
    }
  }

  Widget modalPagoContadoContent(){
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.8,
        child: ListView(
          children: [
            DetailText(texto: 'Nº de Timbrado Entregado', fuente: 15.0,),
            TextField(
              controller: _TimbradoController,
              cursorColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
              style: TextStyle(color: SettingsApp[app_sucursal]!['PrimaryLightColor'] as Color, fontSize: 18.0),
              decoration: InputDecoration(
                icon: Icon(Icons.article_outlined, color: SettingsApp[app_sucursal]!['PrimaryLightColor'] as Color),
                hintText: 'Nº Timbrado',
                border: UnderlineInputBorder(borderSide: BorderSide(color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color)),
                hintStyle: TextStyle(color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color),
              ),
              maxLength: 15,
            ),
            DetailText( texto: 'Nº de Factura Entregado', fuente: 15.0 ),
            TextField(
              controller: _FacturaController,
              cursorColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
              style: TextStyle(color: SettingsApp[app_sucursal]!['PrimaryLightColor'] as Color, fontSize: 18.0),
              decoration: InputDecoration(
                icon: Icon(Icons.article_outlined, color: SettingsApp[app_sucursal]!['PrimaryLightColor'] as Color),
                hintText: 'Nº Factura',
                border: UnderlineInputBorder(borderSide: BorderSide(color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color)),
                hintStyle: TextStyle(color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color),
              ),
              maxLength: 15,
            ),
            const DetailText( texto: 'Efectivo', fuente: 15.0, ),
            MKInputNumber(
              controller: _efectivoController,
              icon: Icons.price_change,
              validator: MKInputNumberValidator.REQUERIDO
            ),
            const DetailText( texto: 'Cheque', fuente: 15.0, ),
            MKInputNumber(
              controller: _chequeController,
              icon: Icons.price_change,
              validator: MKInputNumberValidator.REQUERIDO
            ),
            const DetailText( texto: 'Vale', fuente: 15.0, ),
            MKInputNumber(
              controller: _valeController,
              icon: Icons.price_change,
              validator: MKInputNumberValidator.REQUERIDO
            ),
            const DetailText( texto: 'Tarjeta', fuente: 15.0, ),
            MKInputNumber(
              controller: _tarjetaController,
              icon: Icons.price_change,
              validator: MKInputNumberValidator.REQUERIDO
            ),
            DetailText( texto: 'Total: ' + f.format(totalVenta), fuente: 15.0, ),
            const DetailText( texto: 'Total a cobrar: ', fuente: 15.0, ),
            TextField( controller: _totalController, readOnly: true, textAlign: TextAlign.right, ),
            const DetailText( texto: 'Vuelto: ', fuente: 15.0, ),
            TextField( controller: _vueltoController, readOnly: true, textAlign: TextAlign.right, ),
          ],
        ),
      );
  }

  void modalPagoContado() async {
    calcularTotaACobrar(_cart);
    _efectivoController.text = f.format(totalVenta);
    _FacturaController.text = await servicioCtrl.readSerie();
    _TimbradoController.text = await servicioCtrl.readTimbrado();
    _chequeController.text = '0';
    _valeController.text = '0';
    _tarjetaController.text = '0';
    calcularTotalPagado();

    bool? resultado = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return MKModal(
          titulo: "Método de pago",
          content: modalPagoContadoContent(),
        );
      },
    );

    if (resultado != null && resultado) {
      if(_validarPagoContado() && _validarFacturaTimbrado()){
        Navigator.of(context, rootNavigator: true).pop(context);
        guardarFactura();
      }else{
        modalPagoContado();
      }
    }
  }

  bool _validarPagoContado(){
    int efectivo = int.parse(_efectivoController.text.isEmpty ? '0' : _efectivoController.text.replaceAll(".", ""));
    int cheque = int.parse(_chequeController.text.isEmpty ? '0' : _chequeController.text.replaceAll(".", ""));
    int vale = int.parse(_valeController.text.isEmpty ? '0' : _valeController.text.replaceAll(".", ""));
    int tarjeta = int.parse(_tarjetaController.text.isEmpty ? '0' : _tarjetaController.text.replaceAll(".", ""));

    if((efectivo + cheque + vale + tarjeta) < totalVenta){
      mostrarAlerta("El monto a cobrar es insuficiente. El monto mínimo debe ser ${f.format(totalVenta)} ${Simbolo.GUARANI}", "Error");
      return false;
    }
    return true;
  }

  bool _validarFacturaTimbrado(){
    String Factura = _FacturaController.text;
    String Timbrado = _TimbradoController.text;

    // Definir la expresión regular
    String pattern = r'^\d{3}-\d{3}-\d{7}$';
    RegExp regex = RegExp(pattern);

    // Comprobar si la cadena coincide con el patrón
    if(!regex.hasMatch(Factura)){
      mostrarAlerta("La factura debe tener el siguiente formato: 123-123-1234567", "ERROR");
      return false;
    } 

    // Comprobar si la cadena coincide con el patrón
    if(Timbrado.length < 8 ){
      mostrarAlerta("El timbrado debe tener como mínimo 8 dígitos", "ERROR");
      return false;
    } 

    return true;
  }

  void calcularTotalPagado() {
    cabecera.efectivo = 0;
    cabecera.cheque = 0;
    cabecera.vale = 0;
    cabecera.tarjeta = 0;

    if (_efectivoController.text.isNotEmpty) {
      cabecera.efectivo = int.parse(_efectivoController.text.replaceAll(".", ""));
    }

    if (_chequeController.text.isNotEmpty) {
      cabecera.cheque = int.parse(_chequeController.text.replaceAll(".", ""));
    }

    if (_valeController.text.isNotEmpty) {
      cabecera.vale = int.parse(_valeController.text.replaceAll(".", ""));
    }

    if (_tarjetaController.text.isNotEmpty) {
      cabecera.tarjeta = int.parse(_tarjetaController.text.replaceAll(".", ""));
    }

    totalCobrar = cabecera.efectivo! + cabecera.cheque! + cabecera.tarjeta! + cabecera.vale!;
    vuelto = totalCobrar - totalVenta;

    _totalController.text = f.format(totalCobrar);
    _vueltoController.text = f.format(vuelto);
    setState(() {});
  }

  void calcularTotaACobrar(List<VentaDetalleModel> _cart) {
    cabecera.totale = 0;
    cabecera.total5 = 0;
    cabecera.total10 = 0;
    for (VentaDetalleModel item in _cart) {
      switch (item.idiva) {
        case IvaModel.IVA_0: cabecera.totale = cabecera.totale! + item.subtotal!; break;
        case IvaModel.IVA_5: cabecera.total5 = cabecera.total5! + item.subtotal!; break;
        case IvaModel.IVA_10: cabecera.total10 = cabecera.total10! + item.subtotal!; break;
      }
    }
    totalVenta = cabecera.totale! + cabecera.total5! +cabecera.total10!;
  }

  Container pagoTotal(List<VentaDetalleModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text(
            "Total: ${Simbolo.GUARANI} ${valorTotal(_cart)}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.black)
          )
        ],
      ),
    );
  }

  String valorTotal(List<VentaDetalleModel> listaProductos) {
    int totalVenta = 0;
    for (VentaDetalleModel detail in listaProductos) {
      if (detail.cantidad == null) 
        detail.cantidad = 1;
      totalVenta = totalVenta + (detail.precio! * detail.cantidad!).round();
    }
    // return total.toStringAsFixed(2); // Para poner 2 decimales
    return f.format(totalVenta);
  }

  void _addProduct(int index) {
      if (_cart[index].tipo == TipoInsumo.ARTICULO && _cart[index].stock! >= (_cart[index].cantidad! + 1)) {
        setState(() {
          _cart[index].cantidad = _cart[index].cantidad! + 1;
          _cart[index].subtotal = (_cart[index].precio! * _cart[index].cantidad!).round();
        });
      }else{
        mostrarAlerta("Stock insuficiente. Solo se dispone de ${_cart[index].cantidad!}", "ERROR");
      }
  }

  void _removeProduct(int index) {
    if(_cart[index].tipo == TipoInsumo.ARTICULO && _cart[index].cantidad! > 1){
      setState(() {
        _cart[index].cantidad = _cart[index].cantidad! - 1;
        _cart[index].subtotal = (_cart[index].precio! * _cart[index].cantidad!).round();
      });
    }
  }

  Widget _listView(VentaDetalleModel item, int index){
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
                      title: Text((item.descripcion! + ' ' + item.anho_pago.toString()), style: const TextStyle(fontSize: 20.0),),
                    ),
                    Row(
                      children: [
                        DetailText(
                          texto: 'PRECIO: ' + f.format(item.precio ?? 0) + Simbolo.GUARANI,
                          fuente: 15.0,
                        ),
                        DetailText(
                          texto: ' SUBTOTAL: ' + f.format(item.subtotal ?? 0) + Simbolo.GUARANI,
                          fuente: 15.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width:MediaQuery.of(context).size.width *0.4,
                          height: 40,
                          decoration: BoxDecoration(color: Colors.red[600],
                          boxShadow: const [
                            BoxShadow( blurRadius: 6.0, color: Colors.blue, offset: Offset(0.0, 1.0), )
                          ],
                          borderRadius: const BorderRadius.all(Radius.circular(50.0),)),
                          margin:const EdgeInsets.only(top: 20.0),
                          padding: const EdgeInsets.all(0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const SizedBox(height: 8.0,),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {
                                  _removeProduct(index);
                                  valorTotal(_cart);
                                },
                                color: Colors.yellow,
                              ),
                              Text('${_cart[index].cantidad}', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18.0,color: Colors.white)),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  _addProduct(index);
                                  valorTotal(_cart);
                                },
                                color: Colors.yellow,
                              ),
                              const SizedBox(height: 8.0,)
                            ],
                          ),
                        )
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 10))
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,)
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
          ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cart.length,
            itemBuilder: (context, index) {
              if (_cart[index].cantidad == null) {
                _cart[index].cantidad = 1;
              }
              return _listView(_cart[index], index);
            },
          ),
          const SizedBox(width: 10.0,),
          pagoTotal(_cart),
          const SizedBox(width: 20.0,),
          Container(
            height: 100,
            width: 200,
            padding: const EdgeInsets.only(top: 50),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0),),
              ),
              onPressed: () {
                modalPagoContado();
              },
              child: const Text('GUARDAR'),
            ),
          ),
      ],))
    );
  }

  List<Widget> _actions(){
    return <Widget>[
          IconButton(
            icon: Icon( Icons.list_alt, color: Colors.white, ),
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
                _cart.length;
              });
            },
            color: Colors.white,
          );
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: 'Facturación',
      actions: _actions(),
      leading : _leading(),
      drawer : false,
      body: _body(),
    );
  }

}
