import 'package:expensemanagerapp/ui/helpers/errors/ui_error.dart';
import 'package:get/get.dart';

import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/presentation/protocols/validation.dart';

import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetXAddExpensePresenter implements AddExpensePresenter {
  final LoadPeriods loadPeriod;
  final Validation validation;

  GetXAddExpensePresenter({required this.validation, required this.loadPeriod});

  final _periods = Rx<List<PeriodViewModel>>([]);

  final _periodError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get periodErrorStream => _periodError.stream;

  String? _periodId;

  @override
  Stream<List<PeriodViewModel>> get periodsStream =>
      _periods.stream.map((periods) => periods.toList());

  @override
  Future<void> loadPeriods() async {
    try {
      await loadPeriod.load();
    } catch (error) {
      _periods.subject.addError(
        DomainError.unexpected.description,
        StackTrace.empty,
      );
    }
  }

  @override
  void validatePeriod(String periodId) {
    _periodId = periodId;
    _periodError.value = _validateField('periodId');
  }

  UIError? _validateField(String field) {
    final formData = {
      'periodId': _periodId,
    };

    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      default:
        return null;
    }
  }
}
