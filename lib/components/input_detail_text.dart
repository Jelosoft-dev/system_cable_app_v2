import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  final String texto;
  final double fuente;
  final Color color;

  const DetailText({
    Key? key,
    required this.texto,
    this.fuente = 19.0,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        texto,
        // overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: fuente, color: color),
      ),
    );
  }
}
