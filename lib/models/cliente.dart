class ClienteModel {
  int? id;
  int? ciruc;
  int? verificador;
  DateTime? fechaNac;
  String? razonsocial;
  String? direccion;
  String? telefono;
  String? email;
  String? estado;
  DateTime? creado;
  DateTime? actualizado;
  DateTime? felicitado;

  ClienteModel({
    this.id,
    this.ciruc,
    this.verificador,
    this.fechaNac,
    this.razonsocial,
    this.direccion,
    this.telefono,
    this.email,
    this.estado,
    this.creado,
    this.actualizado,
    this.felicitado,
  });

  // Método para convertir un JSON a un ClienteModel
  factory ClienteModel.fromJson(Map<String, dynamic> json) {
    return ClienteModel(
      id: json['id'],
      ciruc: json['ciruc'],
      verificador: json['verificador'],
      fechaNac: json['fecha_nac'] != null ? DateTime.parse(json['fecha_nac']) : null,
      razonsocial: json['razonsocial'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      email: json['email'],
      estado: json['estado'],
      creado: json['creado'] != null ? DateTime.parse(json['creado']) : null,
      actualizado: json['actualizado'] != null ? DateTime.parse(json['actualizado']) : null,
      felicitado: json['felicitado'] != null ? DateTime.parse(json['felicitado']) : null,
    );
  }

  // Método para convertir un ClienteModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ciruc': ciruc,
      'verificador': verificador,
      'fecha_nac': fechaNac?.toIso8601String(),
      'razonsocial': razonsocial,
      'direccion': direccion,
      'telefono': telefono,
      'email': email,
      'estado': estado,
      'creado': creado?.toIso8601String(),
      'actualizado': actualizado?.toIso8601String(),
      'felicitado': felicitado?.toIso8601String(),
    };
  }
}
