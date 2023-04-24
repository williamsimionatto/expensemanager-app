import 'package:get/get.dart';

import 'package:expensemanagerapp/domain/helpers/helpers.dart';
import 'package:expensemanagerapp/domain/usecases/usecases.dart';

import 'package:expensemanagerapp/presentation/mixins/mixins.dart';
import 'package:expensemanagerapp/presentation/protocols/validation.dart';

import 'package:expensemanagerapp/ui/helpers/helpers.dart';
import 'package:expensemanagerapp/ui/pages/pages.dart';

class GetXAddExpensePresenter extends GetxController
    with FormManager, LoadingManager, ErrorManager, SuccessManager
    implements AddExpensePresenter {
  final Validation validation;
  final LoadPeriods loadPeriod;
  final LoadPeriodCategories loadPeriodCategory;
  final AddExpense addExpense;

  GetXAddExpensePresenter({
    required this.validation,
    required this.loadPeriod,
    required this.loadPeriodCategory,
    required this.addExpense,
  });

  final _periods = Rx<List<PeriodViewModel>>([]);
  final _periodCategories = Rx<List<PeriodCategoryViewModel>>([]);

  final _periodError = Rx<UIError?>(null);
  final _categoryError = Rx<UIError?>(null);
  final _descriptionError = Rx<UIError?>(null);
  final _amountError = Rx<UIError?>(null);
  final _dateError = Rx<UIError?>(null);

  @override
  Stream<UIError?> get periodErrorStream => _periodError.stream;

  @override
  Stream<UIError?> get categoryErrorStream => _categoryError.stream;

  @override
  Stream<UIError?> get descriptionErrorStream => _descriptionError.stream;

  @override
  Stream<UIError?> get amountErrorStream => _amountError.stream;

  @override
  Stream<UIError?> get dateErrorStream => _dateError.stream;

  String? _periodId;
  String? _categoryId;
  String? _description;
  String? _amount;
  String? _date;

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
  Future<void> add() async {
    try {
      isLoading = true;
      mainError = null;

      final params = AddExpenseParams(
        description: _description!,
        amount: double.parse(_amount!),
        date: _date!,
        categoryId: int.parse(_categoryId!),
        periodId: int.parse(_periodId!),
      );

      await addExpense.add(params);
      success = 'Expense added successfully';
    } catch (error) {
      mainError = UIError.unexpected;
      isLoading = false;
    }
  }

  @override
  void validatePeriod(String periodId) {
    _periodId = periodId;
    _periodError.value = _validateField('periodId');
    loadPeriodCategories(_periodId.toString());
    _validateForm();
  }

  @override
  void validateCategory(String categoryId) {
    _categoryId = categoryId;
    _categoryError.value = _validateField('categoryId');
    _validateForm();
  }

  @override
  void validateDescription(String description) {
    _description = description;
    _descriptionError.value = _validateField('description');
    _validateForm();
  }

  @override
  void validateAmount(String amount) {
    _amount = amount;
    _amountError.value = _validateField('amount');
    _validateForm();
  }

  @override
  void validateDate(String date) {
    _date = date;
    _dateError.value = _validateField('date');
    _validateForm();
  }

  @override
  List<Map<String, dynamic>> getPeriods() {
    return _periods.value
        .map((period) => {
              'id': period.id,
              'name': period.name,
            })
        .toList();
  }

  @override
  List<Map<String, dynamic>> getCategories() {
    return _periodCategories.value
        .map((periodCategory) => {
              'id': periodCategory.category.id,
              'name': periodCategory.category.name,
            })
        .toList();
  }

  UIError? _validateField(String field) {
    final formData = {
      'periodId': _periodId,
      'categoryId': _categoryId,
      'description': _description,
      'amount': _amount,
      'date': _date,
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

  void _validateForm() => isFormValid = _periodError.value == null &&
      _categoryError.value == null &&
      _descriptionError.value == null &&
      _amountError.value == null &&
      _dateError.value == null &&
      _periodId != null &&
      _categoryId != null &&
      _description != null &&
      _amount != null &&
      _date != null;
}
