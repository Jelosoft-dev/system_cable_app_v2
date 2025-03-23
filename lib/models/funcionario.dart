class FuncionarioModel {
  int? id;
  String? nombre;
  String? apellido;
  String? nro_documento;
  String? direccion;
  String? telefono;
  int? cargo;
  String? usuario;
  int? estado_civil;
  int? cant_hijo;
  DateTime? fecha_ingreso;
  DateTime? fecha_nacimiento;
  int? sueldo;
  DateTime? pago_sueldo;
  String? tiene_ips;
  int? localidad;
  String? grupo_sangre;
  String? estado;
  DateTime? creado;
  DateTime? actualizado;

  FuncionarioModel({
    this.id,
    this.nombre,
    this.apellido,
    this.nro_documento,
    this.direccion,
    this.telefono,
    this.cargo,
    this.usuario,
    this.estado_civil,
    this.cant_hijo,
    this.fecha_ingreso,
    this.fecha_nacimiento,
    this.sueldo,
    this.pago_sueldo,
    this.tiene_ips,
    this.localidad,
    this.grupo_sangre,
    this.estado,
    this.creado,
    this.actualizado,
  });

  // Método para convertir un JSON a un FuncionarioModel
  factory FuncionarioModel.fromJson(Map<String, dynamic> json) {
    return FuncionarioModel(
      id: json['id'],
      nombre : json['nombre'],
      apellido : json['apellido'],
      nro_documento : json['nro_documento'],
      direccion : json['direccion'],
      telefono : json['telefono'],
      cargo : json['cargo'],
      usuario : json['usuario'],
      estado_civil : json['estado_civil'],
      cant_hijo : json['cant_hijo'],
      fecha_ingreso : json['fecha_ingreso'] != null ? DateTime.parse(json['fecha_ingreso']) : null,
      fecha_nacimiento : json['fecha_nacimiento'] != null ? DateTime.parse(json['fecha_nacimiento']) : null,
      sueldo : json['sueldo'],
      pago_sueldo : json['pago_sueldo'] != null ? DateTime.parse(json['pago_sueldo']) : null,
      tiene_ips : json['tiene_ips'],
      localidad : json['localidad'],
      grupo_sangre : json['grupo_sangre'],
      estado : json['estado'],
      creado : json['creado'] != null ? DateTime.parse(json['creado']) : null,
      actualizado : json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
    );
  }

  // Método para convertir un FuncionarioModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'apellido': apellido,
      'nro_documento': nro_documento,
      'direccion': direccion,
      'telefono': telefono,
      'cargo': cargo,
      'usuario': usuario,
      'estado_civil': estado_civil,
      'cant_hijo': cant_hijo,
      'fecha_ingreso': fecha_ingreso?.toIso8601String(),
      'fecha_nacimiento': fecha_nacimiento?.toIso8601String(),
      'sueldo': sueldo,
      'pago_sueldo': pago_sueldo?.toIso8601String(),
      'tiene_ips': tiene_ips,
      'localidad': localidad,
      'grupo_sangre': grupo_sangre,
      'estado': estado,
      'creado': creado?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
    };
  }
}
