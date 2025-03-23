import 'package:tv_cable/models/conexion.dart';
import 'package:intl/intl.dart';

import 'package:tv_cable/models/trabajo_detalle.dart';
import 'package:tv_cable/models/trabajo_tecnico.dart';

class CabeceraTrabajo {
  String? id;
  String? idcliente;
  String? ciruc;
  String? razonsocial;
  String? telefono;
  String? idreclamo;
  String? reclamo;
  String? iduser;
  String? fecha_recep;
  String? direccion;
  String? obs;
  String? fecha_realizada;
  String? fecha_finalizada;
  String? totale;
  String? total5;
  String? total10;
  String? estado;
  String? tipo;
  String? creado;
  String? anulado;
  String? actualizado;
  String? reversion;
  String? motivo_reversion;

  //Contructor
  CabeceraTrabajo(
    this.id,
    this.idcliente,
    this.idreclamo,
    this.iduser,
    this.fecha_recep,
    this.direccion,
    this.obs,
    this.fecha_realizada,
    this.fecha_finalizada,
    this.totale,
    this.total5,
    this.total10,
    this.estado,
    this.tipo,
    this.creado,
    this.anulado,
    this.actualizado,
    this.reversion,
    this.motivo_reversion,
  );

  CabeceraTrabajo.fromJson(Map<String?, dynamic> json)
      : id = json['id'].toString(),
        idcliente = json['idcliente'].toString(),
        ciruc = json['ciruc'].toString(),
        razonsocial = json['razonsocial'].toString(),
        telefono = json['telefono'].toString(),
        idreclamo = json['idreclamo'].toString(),
        reclamo = json['reclamo'].toString(),
        iduser = json['iduser'].toString(),
        fecha_recep = json['fecha_recep'].toString(),
        direccion = json['direccion'].toString(),
        obs = json['obs'].toString(),
        fecha_realizada = json['fecha_realizada'].toString(),
        fecha_finalizada = json['fecha_finalizada'].toString(),
        totale = json['totale'].toString(),
        total5 = json['total5'].toString(),
        total10 = json['total10'].toString(),
        estado = json['estado'].toString(),
        tipo = json['tipo'].toString(),
        creado = json['creado'].toString(),
        anulado = json['anulado'].toString(),
        actualizado = json['actualizado'].toString(),
        reversion = json['reversion'].toString(),
        motivo_reversion = json['motivo_reversion'].toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'idcliente': idcliente,
        'idreclamo': idreclamo,
        'iduser': iduser,
        'fecha_recep': fecha_recep,
        'direccion': direccion,
        'obs': obs,
        'fecha_realizada': fecha_realizada,
        'fecha_finalizada': fecha_finalizada,
        'totale': totale,
        'total5': total5,
        'total10': total10,
        'estado': estado,
        'tipo': tipo,
        'creado': creado,
        'anulado': anulado,
        'actualizado': actualizado,
        'reversion': reversion,
        'motivo_reversion': motivo_reversion,
      };
}

class EstadoTrabajo{
  static const String PENDIENTE = "P";
  static const String REALIZADO = "R";
}

class TipoTrabajo {
  static const String MANTENIMIENTO = "M";
  static const String CONEXION = "C";
  static const String CORTE = "I";
  static const String RECONEXION = "R";
}

class TrabajoModel{
  int? id;
  int? idcliente;
  ConexionModel? conexion;
  int? idreclamo;
  ConexionModel? reclamo;
  int? iduser;
  DateTime? fecha_recep;
  String? direccion;
  String? obs;
  DateTime? fecha_realizada;
  DateTime? fecha_finalizada;
  int? totale;
  int? total5;
  int? total10;
  String? estado;
  String? tipo;
  DateTime? creado;
  DateTime? anulado;
  DateTime? actualizado;
  DateTime? reversion;
  String? motivo_reversion;
  int? idfactura;
  int? idlocalidad;
  int? revertido_por;
  String? dispositivo;
  List<TrabajoDetalle>? detalles;
  List<TrabajoTecnico>? tecnicos;

  //Contructor
  TrabajoModel(
    this.id,
    this.idcliente,
    this.conexion,
    this.idreclamo,
    this.reclamo,
    this.iduser,
    this.fecha_recep,
    this.direccion,
    this.obs,
    this.fecha_realizada,
    this.fecha_finalizada,
    this.totale,
    this.total5,
    this.total10,
    this.estado,
    this.tipo,
    this.creado,
    this.anulado,
    this.actualizado,
    this.reversion,
    this.motivo_reversion,
    this.idfactura,
    this.idlocalidad,
    this.revertido_por,
    this.dispositivo,
  );

  TrabajoModel.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        idcliente = json['idcliente'],
        conexion = json['idcliente_conexion'] != null 
          ? ConexionModel.fromJson(json['idcliente_conexion']) 
          : null,
        idreclamo = json['idreclamo'],
        reclamo = json['idreclamo_insumo'] != null 
          ? ConexionModel.fromJson(json['idreclamo_insumo']) 
          : null,
        iduser = json['iduser'],
        fecha_recep = json['fecha_recep'] != null ? DateTime.parse(json['fecha_recep']) : null,
        direccion = json['direccion'],
        obs = json['obs'],
        fecha_realizada = json['fecha_realizada'] != null ? DateTime.parse(json['fecha_realizada']) : null,
        fecha_finalizada = json['fecha_finalizada'] != null ? DateTime.parse(json['fecha_finalizada']) : null,
        totale = json['totale'],
        total5 = json['total5'],
        total10 = json['total10'],
        estado = json['estado'],
        tipo = json['tipo'],
        creado = json['creado'] != null ? DateTime.parse(json['creado']) : null,
        anulado = json['anulado'] != null ? DateTime.parse(json['anulado']) : null,
        actualizado = json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
        reversion = json['reversion'] != null ? DateTime.parse(json['reversion']) : null,
        motivo_reversion = json['motivo_reversion'],
        idfactura = json['idfactura'],
        idlocalidad = json['idlocalidad'],
        revertido_por = json['revertido_por'],
        dispositivo = json['dispositivo'],
        detalles = json['detalles'] != null
          ? (json['detalles'] as List).map((i) => TrabajoDetalle.fromJson(i)).toList()
          : null,
        tecnicos = json['tecnicos'] != null
          ? (json['tecnicos'] as List).map((i) => TrabajoTecnico.fromJson(i)).toList()
          : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'idcliente' : idcliente,
        'idreclamo' : idreclamo,
        'iduser' : iduser,
        'fecha_recep' : fecha_recep != null ? DateFormat('dd/MM/yyyy HH:mm').format(fecha_recep!) : null,
        'direccion' : direccion,
        'obs' : obs,
        'fecha_realizada' : fecha_realizada != null ? DateFormat('dd/MM/yyyy HH:mm').format(fecha_realizada!) : null,
        'fecha_finalizada' : fecha_finalizada != null ? DateFormat('dd/MM/yyyy HH:mm').format(fecha_finalizada!) : null,
        'totale' : totale,
        'total5' : total5,
        'total10' : total10,
        'estado' : estado,
        'tipo' : tipo,
        'creado' : creado != null ? DateFormat('dd/MM/yyyy HH:mm').format(creado!) : null,
        'anulado' : anulado != null ? DateFormat('dd/MM/yyyy HH:mm').format(anulado!) : null,
        'actualizado' : actualizado != null ? DateFormat('dd/MM/yyyy HH:mm').format(actualizado!) : null,
        'reversion' : reversion != null ? DateFormat('dd/MM/yyyy HH:mm').format(reversion!) : null,
        'motivo_reversion' : motivo_reversion,
        'idfactura' : idfactura,
        'idlocalidad' : idlocalidad,
        'revertido_por' : revertido_por,
        'dispositivo' : dispositivo,
        'detalles': detalles?.map((detalle) => detalle.toJson()).toList(),
        'tecnicos': tecnicos?.map((tecnico) => tecnico.toJson()).toList(),
    };
}