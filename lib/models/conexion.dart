import 'package:tv_cable/models/cliente.dart';
import 'package:tv_cable/models/funcionario.dart';
import 'package:tv_cable/models/localidad.dart';

class TipoConexion {
  static const String TV = "T";
  static const String INTERNET = "I";
  static const String INTERNET_IP_PUBLICA = "IP";
  static const String INTERNET_Y_TV = "F";
  static const String INTERNET_IP_PUBLICA_Y_TV = "FP";
}

class TipoVivienda {
  static const String PROPIA = "P";
  static const String ALQUILADA = "A";
}

class EstadoConexion {
  // "'I' CORTE, 'P' PENDIENTE, 'A' ACTIVO, 'R' se hizo la reconexión y no se pago aún"
  static const String CORTE = "I";
  static const String PENDIENTE = "P";
  static const String ACTIVO = "A";
  static const String RECONECTADO = "R";
}

class ConexionModel {

  static int ID_DAMOA = 0; 

  int? id;
  int? idcliente;
  int? iduser;
  int? idpromotor;
  int? idlocalidad;
  String? vivienda;
  String? dirCobro;
  String? direccion;
  String? telefono;
  int? cantTv;
  int? cuota;
  DateTime? realizado;
  String? estado;
  DateTime? primerPago;
  DateTime? ultimoPago;
  DateTime? corte;
  DateTime? reconexion;
  int? deuda;
  bool? ordenCorte;
  bool? ordenReconexion;
  bool? ordenPago;
  String? tipo;
  int? deudaAnterior;
  int? deudaPendiente;
  String? lat;
  String? lng;
  String? ipPublica;
  DateTime? creado;
  DateTime? conectado;
  // Otros modelos
  LocalidadModel? localidad;
  FuncionarioModel? promotor;
  ClienteModel? cliente;
  // ClienteModel? usuario;

  ConexionModel({
    this.id,
    this.idcliente,
    this.cliente,
    this.iduser,
    this.idpromotor,
    this.promotor,
    this.idlocalidad,
    this.localidad,
    this.vivienda,
    this.dirCobro,
    this.direccion,
    this.telefono,
    this.cantTv,
    this.cuota,
    this.realizado,
    this.estado,
    this.primerPago,
    this.ultimoPago,
    this.corte,
    this.reconexion,
    this.deuda,
    this.ordenCorte,
    this.ordenReconexion,
    this.ordenPago,
    this.tipo,
    this.deudaAnterior,
    this.deudaPendiente,
    this.lat,
    this.lng,
    this.ipPublica,
    this.creado,
    this.conectado
  });

  // Método para convertir un JSON a un ConexionModel
  ConexionModel.fromJson(Map<String?, dynamic> json)
    : id = json['id'],
      idcliente= json['idcliente'],
      cliente= json['idcliente_cliente'] != null 
          ? ClienteModel.fromJson(json['idcliente_cliente']) 
          : null,
      iduser= json['iduser'],
      idpromotor= json['idpromotor'],
      promotor= json['idpromotor_funcionario'] != null 
          ? FuncionarioModel.fromJson(json['idpromotor_funcionario']) 
          : null,
      idlocalidad= json['idlocalidad'],
      localidad= json['idlocalidad_localidad'] != null 
          ? LocalidadModel.fromJson(json['idlocalidad_localidad']) 
          : null,
      vivienda= json['vivienda'],
      dirCobro= json['dir_cobro'],
      direccion= json['direccion'],
      telefono= json['telefono'],
      cantTv= json['cant_tv'],
      cuota= json['cuota'],
      realizado= json['realizado'] != null ? DateTime.parse(json['realizado']) : null,
      estado= json['estado'],
      primerPago= json['primer_pago'] != null ? DateTime.parse(json['primer_pago']) : null,
      ultimoPago= json['ultimo_pago'] != null ? DateTime.parse(json['ultimo_pago']) : null,
      corte= json['corte'] != null ? DateTime.parse(json['corte']) : null,
      reconexion= json['reconexion'] != null ? DateTime.parse(json['reconexion']) : null,
      deuda= json['deuda'],
      ordenCorte= json['orden_corte'],
      ordenReconexion= json['orden_reconexion'],
      ordenPago= json['orden_pago'],
      tipo= json['tipo'],
      deudaAnterior= json['deuda_anterior'],
      deudaPendiente= json['deuda_pendiente'],
      lat= json['lat'],
      lng= json['lng'],
      ipPublica= json['ip_publica'],
      creado= json['creado'] != null ? DateTime.parse(json['creado']) : null,
      conectado= json['conectado'] != null ? DateTime.parse(json['conectado']) : null;

  // Método para convertir un ConexionModel a JSON
  Map<String, dynamic> toJson() => {
      'id': id,
      'idcliente': idcliente,
      'cliente': cliente?.toJson(),
      'iduser': iduser,
      'idpromotor': idpromotor,
      'promotor': promotor?.toJson(),
      'idlocalidad': idlocalidad,
      'localidad': localidad?.toJson(),
      'vivienda': vivienda,
      'dir_cobro': dirCobro,
      'direccion': direccion,
      'telefono': telefono,
      'cant_tv': cantTv,
      'cuota': cuota,
      'realizado': realizado?.toIso8601String(),
      'estado': estado,
      'primer_pago': primerPago?.toIso8601String(),
      'ultimo_pago': ultimoPago?.toIso8601String(),
      'corte': corte?.toIso8601String(),
      'reconexion': reconexion?.toIso8601String(),
      'deuda': deuda,
      'orden_corte': ordenCorte,
      'orden_reconexion': ordenReconexion,
      'orden_pago': ordenPago,
      'tipo': tipo,
      'deuda_anterior': deudaAnterior,
      'deuda_pendiente': deudaPendiente,
      'lat': lat,
      'lng': lng,
      'ip_publica': ipPublica,
      'creado': creado?.toIso8601String(),
      'conectado': conectado?.toIso8601String(),
  };

  static String TipoConexion(String tipoConexion){
    switch (tipoConexion) {
      case "T": return "TV";
      case "I": return "INTERNET";
      case "IP": return "INTERNET_IP_PUBLICA";
      case "F": return "INTERNET_Y_TV";
      case "FP": return "INTERNET_IP_PUBLICA_Y_TV";
    }
    return 'N/A';
  }


  static String TipoVivienda(String tipoVivienda){
    switch (tipoVivienda) {
      case "P": return "PROPIA";
      case "A": return "ALQUILADA";
    }
    return 'N/A';
  }

  static String EstadoConexion(String estadoConexion){
    // "'I' CORTE, 'P' PENDIENTE, 'A' ACTIVO, 'R' se hizo la reconexión y no se pago aún"
    switch (estadoConexion) {
      case "I": return "CORTE";
      case "P": return "PENDIENTE";
      case "A": return "ACTIVO";
      case "R": return "RECONECTADO";
    }
    return 'N/A';
  }

}
