class UsuarioModel {
  String? id;
  String? usuario;
  String? tipoUsuario;
  String? estado;
  String? email; // Este campo no está en el nuevo JSON, pero lo dejo aquí por si lo necesitas
  String? sucursal;
  String? tokenSession;

  // Constructor
  UsuarioModel({
    this.id,
    this.usuario,
    this.tipoUsuario,
    this.estado,
    this.email,
    this.sucursal,
    this.tokenSession,
  });

  // Constructor from JSON
  UsuarioModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        usuario = json['usuario'],
        tipoUsuario = json['tipo_usuario'].toString(),
        estado = json['estado'],
        sucursal = json['sucursal'].toString(),
        tokenSession = json['token_session'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'usuario': usuario,
        'tipo_usuario': tipoUsuario,
        'estado': estado,
        'sucursal': sucursal,
        'token_session': tokenSession,
      };
}