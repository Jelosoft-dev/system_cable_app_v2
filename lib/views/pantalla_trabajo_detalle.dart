import 'dart:io';
import 'package:tv_cable/components/MKCircularProgress.dart';
import 'package:tv_cable/components/MKDatePicket.dart';
import 'package:tv_cable/components/MKLoader.dart';
import 'package:tv_cable/components/MKTemplateScreen.dart';
import 'package:tv_cable/components/MKTimePicket.dart';
import 'package:tv_cable/components/input_detail_text.dart';
import 'package:tv_cable/components/settings.dart';
import 'package:tv_cable/constants.dart';
import 'package:tv_cable/controllers/servicios_controller.dart';
import 'package:tv_cable/models/trabajo.dart';
import 'package:tv_cable/utils/jasper_report.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/views/pantalla_tecnico_trabajo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class PantallaTrabajoDetalle extends StatefulWidget {
  final TrabajoModel? item;
  PantallaTrabajoDetalle(this.item, {Key? key}) : super(key: key);

  @override
  State<PantallaTrabajoDetalle> createState() =>
      _PantallaTrabajoDetalleState(item);
}

class _PantallaTrabajoDetalleState extends State<PantallaTrabajoDetalle> {
  _PantallaTrabajoDetalleState(this.item);
  TrabajoModel? item;
  ServiciosController servicioCtrl = ServiciosController();

  TextEditingController obs_controller = TextEditingController();

  // NumberFormat f = NumberFormat("#,##0", "es_US");
  NumberFormat f = NumberFormat("#,##0", "es_AR");
  int? _loadingPDF = 0;

  DateTime date_inic = DateTime.now();
  DateTime date_fin = DateTime.now();

  String fecha_inic = '';
  String hora_inic = '';
  String fecha_fin = '';
  String hora_fin = '';

  guardarFechaInic(DateTime date) {
    date_inic = date;
    fecha_inic = DateFormat('dd/MM/yyyy').format(date);
    setState(() {});
  }

  guardarHoraInic(DateTime date) {
    hora_inic = DateFormat('HH:mm').format(date);
    setState(() {});
  }

  guardarFechaFin(DateTime date) {
    date_fin = date;
    fecha_fin = DateFormat('dd/MM/yyyy').format(date);
    setState(() {});
  }

  guardarHoraFin(DateTime date) {
    hora_fin = DateFormat('HH:mm').format(date);
    setState(() {});
  }

  obtenerTipo(String? tipo) {
    switch (tipo) {
      case 'M':
        return 'MANTENIMIENTO';
      case 'C':
        return 'NUEVA CONEXIÓN';
      case 'I':
        return 'CORTE';
      case 'R':
        return 'RECONEXIÓN';
      default:
        return tipo;
    }
  }

  Future<void> downloadAndOpenPdf(int? id) async {
    setState(() { _loadingPDF = id!; });
    Map<String, dynamic> params = {
      'id' : id.toString(),
      'rptName' : 'Trabajo/TicketTrabajoCobradorPDFReport',
    };
    await JasperReport.generar_reporte("api/reportes/trabajos/ticket", "trabajo_ref_${id.toString()}", params: params);
    setState(() { _loadingPDF = 0; });
  }
  
  bool validarCampos() {
    if (fecha_inic.isEmpty) {
      mostrarAlerta('Defina la fecha de inicio.', 'ERROR');
      return false;
    }
    if (hora_inic.isEmpty) {
      mostrarAlerta('Defina la hora de inicio.', 'ERROR');
      return false;
    }
    if (fecha_fin.isEmpty) {
      mostrarAlerta('Defina la fecha de finalización del trabajo.', 'ERROR');
      return false;
    }
    if (hora_fin.isEmpty) {
      mostrarAlerta('Defina la hora de finalización del trabajo.', 'ERROR');
      return false;
    }
    if (fecha_inic == fecha_fin && hora_inic == hora_fin) {
      mostrarAlerta('No puede iniciar y finalizar un trabajo al mismo tiempo.', 'ERROR');
      return false;
    }
    return true;
  }

  registrarTrabajo() {
    if (validarCampos()) {
      this.item?.obs = obs_controller.text;
      this.item?.fecha_realizada = DateFormat('yyyy-MM-dd HH:mm:ss').parse(DateFormat('yyyy-MM-dd').format(date_inic) + ' ' + hora_inic + ':00');
      this.item?.fecha_finalizada =DateFormat('yyyy-MM-dd HH:mm:ss').parse(DateFormat('yyyy-MM-dd').format(date_fin) + ' ' + hora_fin + ':00');
      this.item?.estado = EstadoTrabajo.REALIZADO;
      // Aquí se puede agregar el nombre del dispositivo y enviar al backend.
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PantallaTecnicoTrabajo(this.item!),
        ),
      );
    }
  }

  TextFormField inputTextField(TextEditingController controller, String hintText) {
    return TextFormField(
      //onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.text,
      cursorColor: kPrimaryColor,
      maxLines: 1,
      maxLength: 200,
    );
  }

  TextFormField inputTextFieldNumber(TextEditingController controller, String hintText, IconData icon, bool decimal) {
    return TextFormField(
      //onChanged: onChanged,
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: kPrimaryColor,
      maxLines: 1,
      maxLength: 11,
      inputFormatters: [ThousandsFormatter(allowFraction: decimal)],
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: kPrimaryColor,
        ),
        hintText: hintText,
        // border: InputBorder.none,
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "El campo es obligatorio.";
        }
        return null;
      },
    );
  }

  @override
  initState() {
    super.initState();
    fecha_inic = DateFormat('dd/MM/yyyy').format(date_inic);
    hora_inic = DateFormat('HH:mm').format(date_fin);
    fecha_fin = DateFormat('dd/MM/yyyy').format(date_inic);
    hora_fin = DateFormat('HH:mm').format(date_fin);
  }

  @override
  Widget build(BuildContext context) {
    return MKTemplateScreen(
      title: "Detalles del Trabajo",
      body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              padding: const EdgeInsets.only(
                  top: 30, left: 12.0, right: 12.0, bottom: 12.0),
              children: <Widget>[
                Text(
                  this.item?.conexion?.cliente?.razonsocial ?? '',
                  style: const TextStyle(
                      fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                DetailText(texto:'COD.: ${f.format(this.item?.id! ?? '0')}',fuente: 15.0),
                DetailText(texto: 'RECEPCION: ${this.item?.fecha_recep}',fuente: 15.0),
                DetailText(texto: 'DIRECCIÓN: ${this.item?.direccion}', fuente: 15.0),
                DetailText(texto: 'TIPO: ${obtenerTipo(this.item?.tipo)}',fuente: 15.0,),
                Divider(),
                DetailText(texto: 'Observación:',fuente: 15.0,),
                Container(child: inputTextField(obs_controller, 'Observación'),),
                Row(
                  children: [
                    Text('Fecha Inicio: ' +(fecha_inic == '' ? '---------' : fecha_inic),style: TextStyle(fontSize: 18.0),),
                    MKDatePicker(
                      functionConfirm: guardarFechaInic,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Hora Inicio: ' +(hora_inic == '' ? '---------' : hora_inic),style: TextStyle(fontSize: 18.0),),
                    MKTimePicker(
                      functionConfirm: guardarHoraInic,
                      onChanged: guardarFechaInic,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text('Fecha Fin: ' +(fecha_fin == '' ? '---------' : fecha_fin),style: TextStyle(fontSize: 18.0),),
                    MKDatePicker(
                      functionConfirm: guardarFechaFin,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Hora Fin: ' + (hora_fin == '' ? '---------' : hora_fin),style: TextStyle(fontSize: 18.0),),
                    MKTimePicker(
                      functionConfirm: guardarHoraFin,
                      onChanged: guardarFechaFin,
                    )
                  ],
                ),
                Divider(),
                const Padding(padding: EdgeInsets.only(top: 20.0),),
                (_loadingPDF! > 0 && _loadingPDF == this.item?.id) ? MKCircularProgress()// Cambia al color que desees  
                    :TextButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 40),
                      ),
                      onPressed: () {
                        if(_loadingPDF == 0)
                          downloadAndOpenPdf(this.item?.id);
                      },
                      child: const Text("Imprimir",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                    ),
                const Padding(padding: EdgeInsets.only(top: 20.0),),
                if (this.item?.estado == 'P')
                  TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),),
                    onPressed: () {
                      registrarTrabajo();
                    },
                    child: Text("Continuar ",style: TextStyle(color: Colors.white, fontSize: 18.0),),
                  ),
              ],
            )),
      drawer: false,
    );
  }
}
