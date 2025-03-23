import 'package:flutter/material.dart';
import '../components/settings.dart';

class MKEmpty extends StatelessWidget {

  const MKEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Center(
        child: SizedBox(
          width:
              MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height *
              0.3,
          child: const Card(
            child: Center(
              child: Text(
                'No hay Registro',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
