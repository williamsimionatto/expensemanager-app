import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/components/components.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool?>? stream) {
    stream?.listen((isLoading) async {
      isLoading == true ? await showLoading(context) : hideLoading(context);
    });
  }
}
