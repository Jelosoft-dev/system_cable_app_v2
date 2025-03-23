import 'package:tv_cable/models/conexion.dart';
import 'package:tv_cable/models/usuario.dart';
import 'package:tv_cable/models/venta_detalle.dart';


class EstadoVenta{
  static String ANULADO = "I";
  static String ACTIVO = "A";
}

class CondicionVenta{
  static String CONTADO = "C";
  static String CREDITO = "E";
}

class TipoDocumento{
  static String TICKET = "T";
  static String FACTURA = "F";
}


class VentaModel {
  int? id;
  int? idcajero;
  UsuarioModel? cajero;
  String? serie;
  int? num_fact;
  int? num_ticket;
  int? idconexion;
  ConexionModel? conexion;
  DateTime? fecha;
  String? detalle;
  String? condicion;
  String? estado;
  int? total;
  int? totale;
  int? total5;
  int? total10;
  DateTime? anulado;
  DateTime? vence;
  int? efectivo;
  int? vale;
  int? cheque;
  int? tarjeta;
  int? deuda;
  int? pagado;
  String? tipo_conexion;

  bool? orden_reconexion;
  bool? reconexion;
  DateTime? primer_pago;
  int? cuota;

  String? dispositivo;
  String? dispositivo_anulado;
  String? tipodoc;
  String? num_fact_cobrador;
  String? timbrado;
  int? anulado_por;

  List<VentaDetalleModel>? detalles;
  
  
  //Contructor
  VentaModel({
    this.id,
    this.idcajero,
    this.serie,
    this.num_fact,
    this.num_ticket,
    this.idconexion,
    this.conexion,
    this.fecha,
    this.detalle,
    this.condicion,
    this.estado,
    this.total,
    this.totale,
    this.total5,
    this.total10,
    this.anulado,
    this.vence,
    this.efectivo,
    this.vale,
    this.cheque,
    this.tarjeta,
    this.deuda,
    this.pagado,
    this.tipo_conexion,

    this.orden_reconexion,
    this.reconexion,
    this.primer_pago,
    this.cuota,

    this.dispositivo,
    this.dispositivo_anulado,
    this.tipodoc,
    this.num_fact_cobrador,
    this.timbrado,
    this.anulado_por,
  });


  VentaModel.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        idconexion = json['idconexion'],
        conexion = json['idconexion_conexion'] != null 
          ? ConexionModel.fromJson(json['idconexion_conexion']) 
          : null,
        idcajero = json['idcajero'],
        serie = json['serie'],
        num_fact = json['num_fact'],
        num_ticket = json['num_ticket'],
        fecha = json['fecha'] != null ? DateTime.parse(json['fecha']) : null,
        detalle = json['detalle'],
        condicion = json['condicion'],
        estado = json['estado'],
        total = json['total'],
        totale = json['totale'],
        total5 = json['total5'],
        total10 = json['total10'],
        anulado = json['anulado'] != null ? DateTime.parse(json['anulado']) : null,
        vence = json['vence'] != null ? DateTime.parse(json['vence']) : null,
        efectivo = json['efectivo'],
        vale = json['vale'],
        cheque = json['cheque'],
        tarjeta = json['tarjeta'],
        deuda = json['deuda'],
        pagado = json['pagado'],
        tipo_conexion = json['tipo_conexion'],

        orden_reconexion = json['orden_reconexion'],
        reconexion = json['reconexion'],
        primer_pago = json['primer_pago'] != null ? DateTime.parse(json['primer_pago']) : null,
        cuota = json['cuota'],

        dispositivo = json['dispositivo'],
        dispositivo_anulado = json['dispositivo_anulado'],
        tipodoc = json['tipodoc'],
        num_fact_cobrador = json['num_fact_cobrador'],
        timbrado = json['timbrado'],
        anulado_por = json['anulado_por'],
        detalles = json['detalles'] != null
          ? (json['detalles'] as List).map((i) => VentaDetalleModel.fromJson(i)).toList()
          : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'idconexion': idconexion,
        'conexion': conexion?.toJson(),
        'idcajero' : idcajero,
        'serie' : serie,
        'num_fact' : num_fact,
        'num_ticket' : num_ticket,
        'fecha' : fecha?.toIso8601String(),
        'detalle' : detalle,
        'condicion' : condicion,
        'estado' : estado,
        'total' : total,
        'totale' : totale,
        'total5' : total5,
        'total10' : total10,
        'anulado' : anulado?.toIso8601String(),
        'vence' : vence?.toIso8601String(),
        'efectivo' : efectivo,
        'vale' : vale,
        'cheque' : cheque,
        'tarjeta' : tarjeta,
        'deuda' : deuda,
        'pagado' : pagado,
        'tipo_conexion' : tipo_conexion,

        'orden_reconexion' : orden_reconexion,
        'reconexion' : reconexion,
        'primer_pago' : primer_pago?.toIso8601String(),
        'cuota' : cuota,

        'dispositivo' : dispositivo,
        'dispositivo_anulado' : dispositivo_anulado,
        'tipodoc' : tipodoc,
        'num_fact_cobrador' : num_fact_cobrador,
        'timbrado' : timbrado,
        'anulado_por' : anulado_por,
        'detalles': detalles?.map((detalle) => detalle.toJson()).toList(),
      };
}



