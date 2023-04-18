import 'package:expensemanagerapp/main/builders/validation_builder.dart';
import 'package:expensemanagerapp/presentation/protocols/protocols.dart';
import 'package:expensemanagerapp/validation/protocols/protocols.dart';
import 'package:expensemanagerapp/validation/validators/validators.dart';

Validation makeAddExpenseValidation() =>
    ValidationComposite(makeAddExpenseValidations());

List<FieldValidation> makeAddExpenseValidations() => [
      ...ValidationBuilder.field('description').required().min(5).build(),
      ...ValidationBuilder.field('amount').required().build(),
      ...ValidationBuilder.field('date').required().build(),
      ...ValidationBuilder.field('categoryId').required().build(),
      ...ValidationBuilder.field('periodId').required().build(),
    ];
