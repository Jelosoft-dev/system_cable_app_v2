class VentaDetalleModel {
  int? id;
  int? idventa;
  int? idinsumo;
  String? descripcion;
  int? mes_pago; 
  int? anho_pago;
  double? cantidad;
  int? idiva; 
  double? stock; 
  int? costo;
  int? precio;
  String? tipo; 
  int? subtotal;
  bool? parcial;

  // Constructor
  VentaDetalleModel({
    this.id,
    this.idventa,
    this.idinsumo,
    this.descripcion,
    this.mes_pago,
    this.anho_pago,
    this.cantidad,
    this.idiva,
    this.stock,
    this.costo,
    this.precio,
    this.tipo,
    this.subtotal,
    this.parcial,
  });

  // Constructor from JSON
  VentaDetalleModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        idventa = json['idventa'],
        idinsumo = json['idinsumo'],
        descripcion = json['descripcion'],
        mes_pago = json['mes_pago'],
        anho_pago = json['anho_pago'],
        cantidad = json['cantidad'],        
        idiva = json['idiva'],
        costo = json['costo'],
        precio = json['precio'],
        tipo = json['tipo'],
        subtotal = json['subtotal'],
        parcial = json['parcial'];

  // Método para convertir a JSON
  Map<String, dynamic> toJson() => {
        'id': id,
        'idventa' : idventa,
        'idinsumo' : idinsumo,
        'descripcion' : descripcion,
        'mes_pago' : mes_pago,
        'anho_pago' : anho_pago,
        'cantidad' : cantidad,
        'idiva' : idiva,
        'costo' : costo,
        'precio' : precio,
        'tipo' : tipo,
        'subtotal' : subtotal,
        'parcial' : parcial,
      };
}

