class UltimoPago {
  int? id;
  int? idconexion;
  int? mes;
  int? anho;
  DateTime? creado;
  int? idventa;
  int? monto;
  int? pagado;
  int? deuda;
  bool? copiar_historial;

  //Contructor
  UltimoPago({
    this.id,
    this.idconexion,
    this.mes,
    this.anho,
    this.creado,
    this.idventa,
    this.monto,
    this.pagado,
    this.deuda,
    this.copiar_historial,
  });

  UltimoPago.fromJson(Map<String?, dynamic> json)
      : id = json['id'],
        idconexion = json['idconexion'],
        mes = json['mes'],
        anho = json['anho'],
        creado = json['creado'] != null ? DateTime.parse(json['creado']) : null,
        idventa = json['idventa'],
        monto = json['monto'],
        pagado = json['pagado'],
        deuda = json['deuda'],
        copiar_historial = json['copiar_historial'];

  Map<String, dynamic> toJson() => {
        'mes': mes,
        'anho': anho,
        'deuda': deuda,
        'pagado': pagado,
      };
}
