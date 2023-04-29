import 'package:flutter/material.dart';

Future<DateTime?> datePicker(
  BuildContext context,
  String startDate,
  String endDate,
) async {
  final DateTime start = DateTime.parse(startDate);
  final DateTime end = DateTime.parse(endDate);

  DateTime? date = await showDatePicker(
    context: context,
    initialDate: start,
    firstDate: start,
    lastDate: end,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Theme.of(context).primaryColor,
          ),
        ),
        child: child!,
      );
    },
  );

  return date;
}
