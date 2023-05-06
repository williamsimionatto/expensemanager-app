import 'dart:async';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class AddExpensePresenterSpy extends Mock implements AddExpensePresenter {
  final descriptionErrorController = StreamController<UIError?>();
  final amountErrorController = StreamController<UIError?>();
  final dateErrorController = StreamController<UIError?>();
  final periodErrorController = StreamController<UIError?>();
  final categoryErrorController = StreamController<UIError?>();
  final isFormValidController = StreamController<bool>();
  final mainErrorController = StreamController<UIError?>();
  final successMessageController = StreamController<String>();
  final navigateToController = StreamController<String?>();
  final isLoadingController = StreamController<bool>();

  AddExpensePresenterSpy() {
    when(() => loadPeriods()).thenAnswer((_) async => _);
    when(() => getPeriods()).thenAnswer((_) => []);
    when(() => loadPeriodCategories('')).thenAnswer((_) async => _);
    when(() => getCategories()).thenAnswer((invocation) => []);

    when(() => descriptionErrorStream)
        .thenAnswer((_) => descriptionErrorController.stream);
    when(() => amountErrorStream)
        .thenAnswer((_) => amountErrorController.stream);
    when(() => dateErrorStream).thenAnswer((_) => dateErrorController.stream);
    when(() => periodErrorStream)
        .thenAnswer((_) => periodErrorController.stream);
    when(() => categoryErrorStream)
        .thenAnswer((_) => categoryErrorController.stream);
    when(() => isFormValidStream)
        .thenAnswer((_) => isFormValidController.stream);
    when(() => mainErrorStream).thenAnswer((_) => mainErrorController.stream);
    when(() => successMessageStream)
        .thenAnswer((_) => successMessageController.stream);
    when(() => navigateToStream).thenAnswer((_) => navigateToController.stream);

    when(() => isLoadingStream).thenAnswer((_) => isLoadingController.stream);

    when(() => add()).thenAnswer((_) async => _);
    when(() => isPeriodValid).thenAnswer((_) => true);
    when(() => periodId).thenAnswer((_) => '');
  }

  void emitDescriptionError(UIError error) =>
      descriptionErrorController.add(error);
  void emitDescriptionValid() => descriptionErrorController.add(null);

  void emitAmountError(UIError error) => amountErrorController.add(error);
  void emitAmountValid() => amountErrorController.add(null);

  void emitDateError(UIError error) => dateErrorController.add(error);
  void emitDateValid() => dateErrorController.add(null);

  void emitPeriodError(UIError error) => periodErrorController.add(error);
  void emitPeriodValid() => periodErrorController.add(null);

  void emitCategoryError(UIError error) => categoryErrorController.add(error);
  void emitCategoryValid() => categoryErrorController.add(null);

  void emitFormError() => isFormValidController.add(false);
  void emitFormValid() => isFormValidController.add(true);

  void emitMainError(UIError error) => mainErrorController.add(error);
  void emitSuccess() =>
      successMessageController.add('Expense added successfully');

  void emitNavigateTo(String route) => navigateToController.add(route);

  void dispose() {
    descriptionErrorController.close();
    amountErrorController.close();
    dateErrorController.close();
    periodErrorController.close();
    categoryErrorController.close();
    isFormValidController.close();
    mainErrorController.close();
    successMessageController.close();
    navigateToController.close();
    isLoadingController.close();
  }
}
