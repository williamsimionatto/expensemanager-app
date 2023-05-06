import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String error) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0XFFED5A6C),
      content: Text(
        error,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      duration: const Duration(seconds: 2),
    ),
  );
}
