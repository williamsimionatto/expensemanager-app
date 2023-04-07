import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expensemanagerapp/presentation/protocols/validation.dart';
import 'package:expensemanagerapp/validation/validators/validators.dart';

void main() {
  late MinLengthValidation sut;

  setUp(() {
    sut = const MinLengthValidation(field: 'any_field', size: 5);
  });

  test('Should return error if value is empty', () {
    final formData = {'any_field': ''};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return error if value is null', () {
    final formData = {'any_field': null};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return error if value is less than min size', () {
    final formData = {'any_field': faker.randomGenerator.string(4, min: 1)};
    expect(sut.validate(formData), ValidationError.invalidField);
  });

  test('Should return null if value is equal than min size', () {
    final formData = {'any_field': faker.randomGenerator.string(5, min: 5)};
    expect(sut.validate(formData), null);
  });
}
