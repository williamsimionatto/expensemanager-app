import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/components/components.dart';
import 'package:expensemanagerapp/ui/helpers/helpers.dart';

mixin UIErrorManager {
  void handleMainError(BuildContext context, Stream<UIError?>? stream) {
    stream?.distinct().listen((error) {
      if (error != null) {
        showErrorMessage(context, error.description);
      }
    });
  }
}
