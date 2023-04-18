import 'package:flutter_test/flutter_test.dart';

import 'package:expensemanagerapp/main/factories/pages/pages.dart';
import 'package:expensemanagerapp/validation/validators/validators.dart';

void main() {
  test('Should return the correct validations', () {
    final validations = makeAddExpenseValidations();

    expect(validations, [
      const RequiredFieldValidation('description'),
      const MinLengthValidation(size: 5, field: 'description'),
      const RequiredFieldValidation('amount'),
      const RequiredFieldValidation('date'),
      const RequiredFieldValidation('categoryId'),
      const RequiredFieldValidation('periodId'),
    ]);
  });
}
