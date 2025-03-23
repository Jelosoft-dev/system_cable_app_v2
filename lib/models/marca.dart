class MarcaModel {
  int? id;
  String? descripcion;

  // Constructor
  MarcaModel({
    this.id,
    this.descripcion,
  });

  // Constructor from JSON
  MarcaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descripcion = json['descripcion'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'descripcion': descripcion,
      };
}

