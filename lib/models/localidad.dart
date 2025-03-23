class LocalidadModel {
  String? id;
  String? nombre;

  // Constructor
  LocalidadModel({
    this.id,
    this.nombre,
  });

  // Constructor from JSON
  LocalidadModel.fromJson(Map<String, dynamic> json)
      : id = json['id'].toString(),
        nombre = json['nombre'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };
}

