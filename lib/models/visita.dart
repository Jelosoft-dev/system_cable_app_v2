import 'package:tv_cable/models/conexion.dart';

class Visita {
  String? id;
  String? idconexion;
  ConexionModel? conexion;
  int? iduser;
  DateTime? fecha_creado;
  DateTime? fecha_visitada;
  int? deuda;
  String? descripcion;
  String estado;

  //Contructor
  Visita(
    this.id,
    this.idconexion,
    this.conexion,
    this.iduser,
    this.fecha_creado,
    this.fecha_visitada,
    this.deuda,
    this.descripcion,
    this.estado,
  );

  Visita.fromJson(Map<String?, dynamic> json)
      : id = json['id'].toString(),
        idconexion = json['idconexion'].toString(),
        conexion = json['idconexion_conexion']!= null 
          ? ConexionModel.fromJson(json['idconexion_conexion']) 
        : null,
        iduser = json['iduser'],
        fecha_creado = json['fecha_creado'] != null ? DateTime.parse(json['fecha_creado']) : null,
        fecha_visitada = json['fecha_visitada'] != null ? DateTime.parse(json['fecha_visitada']) : null,
        deuda = json['deuda'],
        descripcion = json['descripcion'].toString(),
        estado = json['estado'].toString();

  Map<String, dynamic> toJson() => {
        'id': id,
        'idconexion': idconexion,
        'iduser': iduser,
        'fecha_creado': fecha_creado?.toIso8601String(),
        'fecha_visitada': fecha_visitada?.toIso8601String(),
        'deuda': deuda,
        'descripcion': descripcion,
        'estado': estado,
      };
}
