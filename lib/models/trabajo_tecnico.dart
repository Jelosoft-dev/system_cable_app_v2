class TrabajoTecnico {
  int? id;
  int? idtrabajo;
  int? idtecnico;
  String? razonsocial;

  //Contructor
  TrabajoTecnico(
    this.id,
    this.idtecnico,
    this.idtrabajo,
  );

  TrabajoTecnico.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        idtecnico = json['id'],
        razonsocial = json['descripcion'].toString(),
        idtrabajo = json['idtrabajo'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'idtecnico': idtecnico,
        'razonsocial': razonsocial,
        'idtrabajo': idtrabajo,
      };
}
