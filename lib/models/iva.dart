class IvaModel {

  static const int IVA_0 = 1;
  static const int IVA_5 = 2;
  static const int IVA_10 = 3;

  int? id;
  int? nombre;

  // Constructor
  IvaModel({
    this.id,
    this.nombre,
  });

  // Constructor from JSON
  IvaModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        nombre = json['nombre'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
      };
}

