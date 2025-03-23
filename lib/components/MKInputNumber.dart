import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

class MKInputNumberValidator{
  static String? REQUERIDO(value) {
    if (value == null || value.isEmpty) {
      return "Por favor, ingrese un valor.";
    }
    return null;
  }

  static String? REQUERIDO_MAYOR_A_0(value) {
    if (value == null || value.isEmpty) {
      return "Por favor, ingrese un valor.";
    }
    print(value);
    if (int.parse(value) <= 0) {
      return "Por favor, ingrese un valor mayor a 0.";
    }
    return null;
  }

}

class MKInputNumber extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool decimal;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  MKInputNumber({
    required this.controller,
    this.hintText = 'Introduce un número',
    required this.icon,
    this.decimal = false,
    this.onChanged,
    this.validator,
  });

  NumberFormat formatter = NumberFormat("#,###.##", "es_AR");

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: 1,
      maxLength: 11,
      inputFormatters: [ThousandsFormatter(formatter: formatter, allowFraction: decimal)],
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        hintText: hintText,
      ),
      validator: validator ?? (String? value) {
        if (value == null || value.isEmpty) {
          return "El campo es obligatorio.";
        }
        return null;
      },
      onChanged: onChanged ?? (value) {},
    );
  }
}

// class ThousandsFormatter extends TextInputFormatter {
//   final bool allowFraction;

//   ThousandsFormatter({this.allowFraction = false});

//   @override
//   TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
//     // Implementa la lógica del formateo aquí.
//     // Por ejemplo, puedes usar un paquete como 'intl' para formatear números.
//     return newValue;
//   }
// }
