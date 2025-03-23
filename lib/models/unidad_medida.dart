class UnidadMedidaModel {
  int? id;
  String? descripcion;

  // Constructor
  UnidadMedidaModel({
    this.id,
    this.descripcion,
  });

  // Constructor from JSON
  UnidadMedidaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        descripcion = json['descripcion'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'descripcion': descripcion,
      };
}

