import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tv_cable/components/settings.dart';

class MKTimePicker extends StatefulWidget {
  final Function(DateTime) functionConfirm;
  final DateTime? currentTime;
  final bool showTitleActions;
  final Function(DateTime)? onChanged;

  MKTimePicker({
    required this.functionConfirm,
    this.currentTime,
    this.showTitleActions = true,
    this.onChanged,
  });

  @override
  _MKTimePickerState createState() => _MKTimePickerState();
}

class _MKTimePickerState extends State<MKTimePicker> {
  Future<void> _showTimePicker() async {
    DatePicker.showTimePicker(context,
      showTitleActions: widget.showTitleActions,
      theme: DatePickerTheme(
        headerColor: Colors.green[300],
        backgroundColor: Colors.blueGrey,
        itemStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        doneStyle: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onChanged: (date) {
        if (widget.onChanged != null) {
          widget.onChanged!(date);
        }
      },
      onConfirm: (date) {
        widget.functionConfirm(date);
      },
      currentTime: widget.currentTime ?? DateTime.now(),
      locale: LocaleType.es,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
            onPressed: _showTimePicker,
            icon: Icon(Icons.timelapse,color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,size: 28.0,),
          );
  }
}
