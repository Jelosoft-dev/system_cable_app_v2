class Auth {
  int? id;
  String? usuario;
  int? tipoUsuario;
  String? estado;
  int? sucursal;
  List<Permiso>? permisos;
  String? tokenSession;

  // Constructor
  Auth({
    this.id,
    this.usuario,
    this.tipoUsuario,
    this.estado,
    this.sucursal,
    this.permisos,
    this.tokenSession,
  });

  // Constructor from JSON
  Auth.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        usuario = json['usuario'],
        tipoUsuario = json['tipo_usuario'],
        estado = json['estado'],
        sucursal = json['sucursal'],
        permisos = json['permisos'] != null
            ? (json['permisos'] as List).map((i) => Permiso.fromJson(i)).toList()
            : null,
        tokenSession = json['token_session'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'usuario': usuario,
        'tipo_usuario': tipoUsuario,
        'estado': estado,
        'sucursal': sucursal,
        'permisos': permisos?.map((i) => i.toJson()).toList(),
        'token_session': tokenSession,
      };
}

class Permiso {
  int? id;
  String? descripcion;

  // Constructor
  Permiso({
    this.id,
    this.descripcion,
  });

  // Constructor from JSON
  Permiso.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        descripcion = json['descripcion'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'descripcion': descripcion,
      };
}
