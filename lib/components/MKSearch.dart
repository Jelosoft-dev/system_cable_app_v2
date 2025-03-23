import 'package:flutter/material.dart';
import 'package:tv_cable/components/settings.dart';

class MKSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearchTextChanged;

  const MKSearch({
    Key? key,
    required this.controller,
    required this.onSearchTextChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color, // Cambia al color que desees, o utiliza kPrimaryColor si está definido en tu contexto
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Buscar',
                border: InputBorder.none,
              ),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }
}
