class CajaModel {
  String? estadoCaja;
  ConfigCaja? configCaja;
  int? numFact;

  CajaModel({this.estadoCaja, this.configCaja, this.numFact});

  factory CajaModel.fromJson(Map<String?, dynamic> json) {
    return CajaModel(
      estadoCaja: json['estado_caja'],
      configCaja: json['config_caja'] != null ? ConfigCaja.fromJson(json['config_caja']) : null,
      numFact: json['num_fact'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['estado_caja'] = estadoCaja;
    if (configCaja != null) {
      data['config_caja'] = configCaja!.toJson();
    }
    data['num_fact'] = numFact;
    return data;
  }
}

class ConfigCaja {
  int? id;
  int? idcajero;
  int? inicioFact;
  int? inicioTicket;
  String? numCaja;
  String? serie1;
  String? serie2;
  String? imp1;
  String? imp2;
  String? imp3;
  String? maquina;
  String? timbrado;
  String? inicioVigencia;
  String? finVigencia;
  String? creado;

  ConfigCaja({
    this.id,
    this.idcajero,
    this.inicioFact,
    this.inicioTicket,
    this.numCaja,
    this.serie1,
    this.serie2,
    this.imp1,
    this.imp2,
    this.imp3,
    this.maquina,
    this.timbrado,
    this.inicioVigencia,
    this.finVigencia,
    this.creado,
  });

  factory ConfigCaja.fromJson(Map<String, dynamic> json) {
    return ConfigCaja(
      id: json['id'],
      idcajero: json['idcajero'],
      inicioFact: json['inicio_fact'],
      inicioTicket: json['inicio_ticket'],
      numCaja: json['num_caja'],
      serie1: json['serie1'],
      serie2: json['serie2'],
      imp1: json['imp1'],
      imp2: json['imp2'],
      imp3: json['imp3'],
      maquina: json['maquina'],
      timbrado: json['timbrado'],
      inicioVigencia: json['inicio_vigencia'],
      finVigencia: json['fin_vigencia'],
      creado: json['creado'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idcajero'] = idcajero;
    data['inicio_fact'] = inicioFact;
    data['inicio_ticket'] = inicioTicket;
    data['num_caja'] = numCaja;
    data['serie1'] = serie1;
    data['serie2'] = serie2;
    data['imp1'] = imp1;
    data['imp2'] = imp2;
    data['imp3'] = imp3;
    data['maquina'] = maquina;
    data['timbrado'] = timbrado;
    data['inicio_vigencia'] = inicioVigencia;
    data['fin_vigencia'] = finVigencia;
    data['creado'] = creado;
    return data;
  }
}
