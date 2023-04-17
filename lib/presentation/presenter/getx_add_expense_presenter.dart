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
  final _categoryError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get periodErrorStream => _periodError.stream;

  @override
  Stream<UIError?> get categoryErrorStream => _categoryError.stream;

  String? _periodId;
  String? _categoryId;

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
          .map(
            (period) => PeriodViewModel(
              id: period.id,
              name: period.name,
              startDate: period.startDate,
              endDate: period.endDate,
              budget: period.budget,
            ),
          )
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
      final periodCategories = await loadPeriodCategory.load(periodId);
      _periodCategories.value = periodCategories
          .map(
            (periodCategory) => PeriodCategoryViewModel(
              id: periodCategory.id,
              budget: periodCategory.budget,
              category: CategoryViewModel(
                id: periodCategory.category.id,
                name: periodCategory.category.name,
                description: periodCategory.category.description,
              ),
            ),
          )
          .toList();
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

  @override
  void validateCategory(String categoryId) {
    _categoryId = categoryId;
    _categoryError.value = _validateField('categoryId');
    _validateForm();
  }

  UIError? _validateField(String field) {
    final formData = {
      'periodId': _periodId,
      'categoryId': _categoryId,
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
