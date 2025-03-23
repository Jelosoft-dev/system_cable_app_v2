import './settings.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;

  RoundedButton._({
    Key? key,
    required this.text,
    required this.press,
    required this.color,
    this.textColor = Colors.white,
  }) : super(key: key);

  factory RoundedButton({
    Key? key,
    required String text,
    required Function press,
  }) {
    Color primaryColor = SettingsApp['DESARROLLO']!['PrimaryColor'] as Color;
    return RoundedButton._(
      key: key,
      text: text,
      press: press,
      color: primaryColor,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          ),
          onPressed: () {},
          child: Text(
            text,
            style: TextStyle(color: textColor, fontSize: 20.0),
          ),
        ),
      ),
    );
  }
}
