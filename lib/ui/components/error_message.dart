import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0XFFF64348),
      content: Text(error, textAlign: TextAlign.center),
    ),
  );
}
