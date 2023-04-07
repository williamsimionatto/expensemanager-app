import 'package:expensemanagerapp/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../validation/mocks/mocks.dart';

void main() {
  late ValidationComposite sut;
  late FieldValidationSpy validation1;
  late FieldValidationSpy validation2;
  late FieldValidationSpy validation3;

  setUp(() {
    validation1 = FieldValidationSpy();
    validation1.mockFieldName('other_field');
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();
    sut = ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', () {
    final error =
        sut.validate(field: 'any_field', input: {'any_field': 'any_value'});
    expect(error, null);
  });
}
