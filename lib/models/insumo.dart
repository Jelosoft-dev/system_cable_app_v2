import 'package:tv_cable/models/categoria.dart';
import 'package:tv_cable/models/iva.dart';
import 'package:tv_cable/models/marca.dart';
import 'package:tv_cable/models/unidad_medida.dart';
import 'package:intl/intl.dart';

class EstadoInsumo {
  static String ACTIVO = "A";
  static String INACTIVO = "I";
}

class TipoInsumo{
  static String ARTICULO = "I";
  static String SERVICIO = "S";
  static String MENSUALIDAD = "M";
  
  static int CONEXION_SERVICIO = 49;
  static int CONEXION_INTERNET = 55;
  static int CONEXION_TV = 61;
  static int CONEXION_TV_INTERNET = 62;

  static int RECONEXION_INTERNET = 48;
  static int RECONEXION_TV = 63;
  static int RECONEXION_TV_INTERNET = 63;
  
  static int CORTE_INTERNET = 47;
  static int CORTE_TV = 64;
  static int CORTE_TV_INTERNET = 89;

  static List<int> ID_PAGO_COMPLETO = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12 ];
  static List<int> ID_PAGO_PARCIAL = [ 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24 ];
  static int DEUDA_PENDIENTE = 43;

  static List<int> TIPO_CONEXION = [
    TipoInsumo.CONEXION_SERVICIO,
    TipoInsumo.CONEXION_INTERNET,
    TipoInsumo.CONEXION_TV,
    TipoInsumo.CONEXION_TV_INTERNET,
  ];

  static List<int> TIPO_RECONEXION = [
    TipoInsumo.RECONEXION_INTERNET,
    TipoInsumo.RECONEXION_TV,
    TipoInsumo.RECONEXION_TV_INTERNET,
  ];

  static List<int> TIPO_CORTE = [
    TipoInsumo.CORTE_INTERNET,
    TipoInsumo.CORTE_TV,
    TipoInsumo.CORTE_TV_INTERNET,
  ];

  static List<int>  ID_PAGOS = [...TipoInsumo.ID_PAGO_COMPLETO, ...TipoInsumo.ID_PAGO_PARCIAL];

}


class InsumoModel {
  int? id;
  String? nombre;
  String? codbar;
  String? descripcion;
  String? stock;
  int? stockmin;
  int? costo;
  int? costopp;
  int? precio_min;
  int? precio_max;
  int? idcategoria;
  CategoriaModel? categoria;
  int? idmarca;
  MarcaModel? marca;
  int? idiva;
  IvaModel? iva;
  String? tipo;
  String? estado;
  DateTime? creado;
  DateTime? desde;
  DateTime? hasta;
  String? foto1;
  String? foto2;
  int? IdUnidadMedida;
  UnidadMedidaModel? unidadMedida;

  InsumoModel({
    this.id,
    this.nombre,
    this.codbar,
    this.descripcion,
    this.stock,
    this.stockmin,
    this.costo,
    this.costopp,
    this.precio_min,
    this.precio_max,
    this.idcategoria,
    this.categoria,
    this.idmarca,
    this.marca,
    this.idiva,
    this.iva,
    this.tipo,
    this.estado,
    this.creado,
    this.desde,
    this.hasta,
    this.foto1,
    this.foto2,
    this.IdUnidadMedida,
    this.unidadMedida,
  });

  // Método para convertir un JSON a un InsumoModel
  factory InsumoModel.fromJson(Map<String, dynamic> json) {
    return InsumoModel(
      id: json['id'],
      nombre : json['nombre'],
      codbar : json['codbar'],
      descripcion : json['descripcion'],
      stock : json['stock'].toString(),
      stockmin : json['stockmin'],
      costo : json['costo'],
      costopp : json['costopp'],
      precio_min : json['precio_min'],
      precio_max : json['precio_max'],
      idcategoria : json['idcategoria'],
      categoria : json['idcategoria_categoria'] != null 
          ? CategoriaModel.fromJson(json['idcategoria_categoria']) 
          : null,
      idmarca : json['idmarca'],
      marca : json['idmarca_marca'] != null 
          ? MarcaModel.fromJson(json['idmarca_marca']) 
          : null,
      idiva : json['idiva'],
      iva : json['idiva_iva'] != null 
          ? IvaModel.fromJson(json['idiva_iva']) 
          : null,
      tipo : json['tipo'].toString(),
      estado : json['estado'].toString(),
      creado : json['creado'] != null ? DateTime.parse(json['creado']) : null,
      desde : json['desde'] != null ? DateTime.parse(json['desde']) : null,
      hasta : json['hasta'] != null ? DateTime.parse(json['hasta']) : null,
      foto1 : json['foto1'].toString(),
      foto2 : json['foto2'].toString(),
      IdUnidadMedida : json['IdUnidadMedida'],
      unidadMedida : json['unidad_medida_unidad_medida'] != null 
          ? UnidadMedidaModel.fromJson(json['unidad_medida_unidad_medida']) 
          : null,
    );
  }

  // Método para convertir un InsumoModel a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre' : nombre,
      'codbar' : codbar,
      'descripcion' : descripcion,
      'stock' : stock,
      'stockmin' : stockmin,
      'costo' : costo,
      'costopp' : costopp,
      'precio_min' : precio_min,
      'precio_max' : precio_max,
      'idcategoria' : idcategoria,
      'categoria' : categoria?.toJson(),
      'idmarca' : idmarca,
      'marca' : marca?.toJson(),
      'idiva' : idiva,
      'iva' : iva?.toJson(),
      'tipo' : tipo,
      'estado' : estado,
      'creado' : creado,
      'desde' : desde != null ? DateFormat('dd/MM/yyyy HH:mm').format(desde!) : null,
      'hasta' : hasta != null ? DateFormat('dd/MM/yyyy HH:mm').format(hasta!) : null,
      'foto1' : foto1,
      'foto2' : foto2,
      'IdUnidadMedida' : IdUnidadMedida,
      'unidadMedida' : unidadMedida?.toJson(),
    };
  }
}
