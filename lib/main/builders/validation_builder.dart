import 'package:expensemanagerapp/validation/protocols/protocols.dart';
import 'package:expensemanagerapp/validation/validators/validators.dart';

class ValidationBuilder {
  static ValidationBuilder _instance = ValidationBuilder._();
  late String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._();

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._();
    _instance.fieldName = fieldName;

    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder min(int size) {
    validations.add(MinLengthValidation(field: fieldName, size: size));
    return this;
  }

  List<FieldValidation> build() => validations;
}
