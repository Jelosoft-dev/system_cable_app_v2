class CategoriaModel {
  int? id;
  String? descripcion;

  // Constructor
  CategoriaModel({
    this.id,
    this.descripcion,
  });

  // Constructor from JSON
  CategoriaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descripcion = json['descripcion'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'descripcion': descripcion,
      };
}

