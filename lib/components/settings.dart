import 'package:flutter/material.dart';

var nombreApp = '';
var nombreLogo = '';
const URL = [
  'http://192.168.100.14:4000/api',
  'https://www.hcv.grupodamoa.com.py',
  'https://www.belencv.grupodamoa.com.py',
  'https://www.cvl.grupodamoa.com.py',
  'https://www.santani.grupodamoa.com.py',
  'https://www.chore.grupodamoa.com.py',
  'https://www.sanpedro.grupodamoa.com.py',
  'https://www.ycv.grupodamoa.com.py',
  'https://www.tacuati.grupodamoa.com.py',
];

final SettingsApp = {
  'DESARROLLO': {
    'id': 0,
    'url': '192.168.100.14:4000',//http://
    'name': 'System Cable Develop',
    'logo': 'assets/logo_damoa.png',
    'PrimaryColor': Colors.indigo,
    'PrimaryLightColor': Colors.lightBlue,
  },
  'HORQUETA_CV': {
    'id': 0,
    'url': 'http://147.93.69.11:9000',
    'name': 'Horqueta Cable Visión',
    'logo': 'assets/logo_damoa.png',
    'PrimaryColor': Colors.indigo,
    'PrimaryLightColor': Colors.lightBlue,
  },
  'BELEN_CV': {
    'id': 1,
    'url': 'https://www.belencv.grupodamoa.com.py',
    'name': 'Belén Cable Visión',
    'logo': 'assets/logo_bcv.png',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  },
  'LORETO_CV': {
    'id': 2,
    'url': 'https://www.cvl.grupodamoa.com.py',
    'name': 'Loreto Cable Visión',
    'logo': 'assets/logo_lcv.jpg',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  },
  'TAPIRACUAI_CV': {
    'id': 0,
    'url': 'https://www.santani.grupodamoa.com.py',
    'name': 'Tapiracuai Cable Visión',
    'logo': 'assets/logo_scv.png',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  },
  'CACIQUE_CV': {
    'id': 0,
    'url': 'https://www.chore.grupodamoa.com.py',
    'name': 'Cacique Cable Visión',
    'logo': 'assets/logo_chore.png',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  },
  'NORTE_CV': {
    'id': 0,
    'url': 'https://www.sanpedro.grupodamoa.com.py',
    'name': 'Norte Cable Visión',
    'logo': 'assets/logo_sp.png',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  },
  'YBY_YAU_CV': {
    'id': 0,
    'url': 'https://www.ycv.grupodamoa.com.py',
    'name': 'Yby Ya`u Cable Visión',
    'logo': 'assets/logo_ycv.png',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  },
  'TACUATI_CV': {
    'id': 0,
    'url': 'https://www.tacuati.grupodamoa.com.py',
    'name': 'Tacuati Cable Visión',
    'logo': 'assets/logo_tcv.png',
    'PrimaryColor': Colors.amber,
    'PrimaryLightColor': Colors.deepOrange,
  }
};
/**
 * 0 = Desarrollo
 * 1 = Horqueta Cable Visión
 * 2 = Belén Cable Visión
 * 3 = Loreto Cable Visión
 * 4 = Tapiracuai Cable Visión
 * 5 = Cacique Cable Visión
 * 6 = Norte Cable Visión
 * 7 = Yby Ya`u Cable Visión
 * 8 = Tacuati Cable Visión
 */
final app_sucursal = 'HORQUETA_CV';
