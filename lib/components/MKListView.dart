import 'package:flutter/material.dart';
import 'package:tv_cable/components/MKSearch.dart';
import 'package:tv_cable/utils/mostrar_alerta.dart';
import 'package:tv_cable/components/MKEmpty.dart';
import 'package:tv_cable/components/settings.dart';

class MKListView extends StatelessWidget {
  final Stream<List<dynamic>> stream;
  final Widget? Function(Object, dynamic) contenido;
  final Function(String) onSearchTextChanged;
  final Future<void> Function() onRefresh;
  final TextEditingController searchController;

  MKListView({
    Key? key,
    required this.stream,
    required this.contenido,
    required this.onRefresh,
    required this.onSearchTextChanged,
    required this.searchController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MKSearch(controller: searchController, onSearchTextChanged: onSearchTextChanged,),
        Expanded(
          child: StreamBuilder<List<dynamic>>(
            stream: stream,
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasError) {
                // Mostrar alerta en caso de error
                mostrarAlerta(snapshot.error.toString(), "ERROR");
              }
              return snapshot.hasData
                  ? RefreshIndicator(
                      onRefresh: onRefresh,
                      child: snapshot.data!.isEmpty
                          ? MKEmpty() // Reemplaza con tu widget de lista vacía
                          : ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final instancia = snapshot.data![index]; // Ajusta según tu tipo de datos
                                return contenido(instancia, index);
                              },
                            ),
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        backgroundColor: SettingsApp[app_sucursal]!['PrimaryLightColor'] as Color,
                      ),
                    );
            },
          ),
        ),
      ],
    );
  }
}
