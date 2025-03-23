import 'settings.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final int maxLines;
  final int maxLength;
  final String hintText;
  final IconData icon;
  final TextEditingController inputController;
  final TextInputType tipo;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.inputController,
    this.maxLines = 1,
    this.maxLength = 250,
    this.tipo = TextInputType.text,
    this.icon = Icons.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //onChanged: onChanged,
      controller: inputController,
      keyboardType: tipo,
      cursorColor: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
      maxLines: maxLines,
      maxLength: maxLength,
      decoration: InputDecoration(
        icon: Icon(
          icon,
          color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,
        ),
        hintText: hintText,
        // border: InputBorder.none,
      ),
      validator: (String? value) {
        if (value!.isEmpty) {
          return "El campo es obligatorio.";
        }
        return null;
      },
    );
  }
}
