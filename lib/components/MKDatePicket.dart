import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tv_cable/components/settings.dart';

class MKDatePicker extends StatefulWidget {
  final Function(DateTime) functionConfirm;
  final DateTime? currentTime;
  final bool showTitleActions;
  final DateTime? minTime;
  final DateTime? maxTime;
  final Function(DateTime)? onChanged;

  MKDatePicker({
    required this.functionConfirm,
    this.currentTime,
    this.showTitleActions = true,
    this.minTime,
    this.maxTime,
    this.onChanged,
  });

  @override
  _MKDatePickerState createState() => _MKDatePickerState();
}

class _MKDatePickerState extends State<MKDatePicker> {
  Future<void> _showDatePicker() async {
    DatePicker.showDatePicker(context,
      showTitleActions: widget.showTitleActions,
      minTime: widget.minTime ?? DateTime(2015, 01, 01),
      maxTime: widget.maxTime ?? DateTime.now(),
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
            onPressed: _showDatePicker,
            icon: Icon(Icons.date_range,color: SettingsApp[app_sucursal]!['PrimaryColor'] as Color,size: 28.0,),
          );
  }
}
