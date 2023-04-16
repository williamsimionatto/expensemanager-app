import 'package:get/get.dart';

import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/presentation/mixins/mixins.dart';
import 'package:expensemanagerapp/presentation/protocols/validation.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetXAddExpensePresenter extends GetxController
    with FormManager
    implements AddExpensePresenter {
  final Validation validation;
  final LoadPeriods loadPeriod;
  final LoadPeriodCategories loadPeriodCategory;

  GetXAddExpensePresenter({
    required this.validation,
    required this.loadPeriod,
    required this.loadPeriodCategory,
  });

  final _periods = Rx<List<PeriodViewModel>>([]);
  final _periodCategories = Rx<List<PeriodCategoryViewModel>>([]);

  final _periodError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get periodErrorStream => _periodError.stream;

  String? _periodId;

  @override
  Stream<List<PeriodViewModel>> get periodsStream =>
      _periods.stream.map((periods) => periods.toList());

  @override
  Stream<List<PeriodCategoryViewModel>> get periodCategoriesStream =>
      _periodCategories.stream
          .map((periodCategories) => periodCategories.toList());

  @override
  Future<void> loadPeriods() async {
    try {
      final periods = await loadPeriod.load();
      _periods.value = periods
          .map((period) => PeriodViewModel(
                id: period.id,
                name: period.name,
                startDate: period.startDate,
                endDate: period.endDate,
                budget: period.budget,
              ))
          .toList();
    } catch (error) {
      _periods.subject.addError(
        DomainError.unexpected.description,
        StackTrace.empty,
      );
    }
  }

  @override
  Future<void> loadPeriodCategories(String periodId) async {
    try {
      await loadPeriodCategory.load(periodId);
    } catch (error) {
      _periodCategories.subject.addError(
        DomainError.unexpected.description,
        StackTrace.empty,
      );
    }
  }

  @override
  void validatePeriod(String periodId) {
    _periodId = periodId;
    _periodError.value = _validateField('periodId');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      'periodId': _periodId,
    };

    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      default:
        return null;
    }
  }

  void _validateForm() => isFormValid = false;
}
