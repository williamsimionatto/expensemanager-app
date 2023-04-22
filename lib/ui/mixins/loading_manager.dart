import 'package:flutter/material.dart';

import 'package:expensemanagerapp/ui/components/components.dart';

mixin LoadingManager {
  void handleLoading(BuildContext context, Stream<bool?>? stream) {
    stream?.listen((isLoading) async {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        isLoading == true ? await showLoading(context) : hideLoading(context);
      });
    });
  }
}
