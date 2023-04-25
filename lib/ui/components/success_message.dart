import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green[700],
      content: Text(message, textAlign: TextAlign.center),
    ),
  );
}
