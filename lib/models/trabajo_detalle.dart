class TrabajoDetalle {
  int? id;
  int? idtrabajo;
  int? idinsumo;
  String? nombre;
  String? tipo;
  int? cantidad;
  int? costo;
  int? subtotal;

  //Contructor
  TrabajoDetalle(
    this.id,
    this.idtrabajo,
    this.idinsumo,
    this.nombre,
    this.tipo,
    this.cantidad,
    this.costo,
    this.subtotal,
  );

  TrabajoDetalle.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        idtrabajo = json['idtrabajo'],
        idinsumo = json['idinsumo'],
        nombre = json['nombre'].toString(),
        tipo = json['tipo'].toString(),
        cantidad = json['cantidad'],
        costo = json['costo'],
        subtotal = json['subtotal'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'idtrabajo': idtrabajo,
        'idinsumo': idinsumo,
        'nombre': nombre,
        'tipo': tipo,
        'cantidad': cantidad,
        'costo': costo,
        'subtotal': subtotal,
      };
}
