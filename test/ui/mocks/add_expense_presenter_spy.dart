import 'dart:async';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class AddExpensePresenterSpy extends Mock implements AddExpensePresenter {
  final descriptionErrorController = StreamController<UIError?>();

  AddExpensePresenterSpy() {
    when(() => loadPeriods()).thenAnswer((_) async => _);
    when(() => getPeriods()).thenAnswer((_) => []);
    when(() => loadPeriodCategories('')).thenAnswer((_) async => _);
    when(() => getCategories()).thenAnswer((invocation) => []);
    when(() => descriptionErrorStream)
        .thenAnswer((_) => descriptionErrorController.stream);
  }

  void emitDescriptionError(UIError error) =>
      descriptionErrorController.add(error);
  void emitDescriptionValid() => descriptionErrorController.add(null);

  void dispose() {
    descriptionErrorController.close();
  }
}
