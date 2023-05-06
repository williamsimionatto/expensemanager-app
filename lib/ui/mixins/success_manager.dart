import 'package:expensemanagerapp/ui/components/components.dart';
import 'package:flutter/widgets.dart';

mixin SuccessManager {
  void handleSuccessMessage(BuildContext context, Stream<String?>? stream) {
    stream?.distinct().listen((message) {
      if (message != null) {
        showSuccessMessage(context, message);
      }
    });
  }
}
