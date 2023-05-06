import 'package:flutter/material.dart';

Future<void> showLoading(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return SimpleDialog(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 10),
              const Text(
                'Waiting ... ',
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      );
    },
  );
}

void hideLoading(BuildContext? context) {
  if (context != null && ModalRoute.of(context)?.canPop == true) {
    Navigator.of(context).pop();
  }
}
