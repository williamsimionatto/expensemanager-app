import 'package:expensemanagerapp/presentation/protocols/protocols.dart';
import 'package:expensemanagerapp/validation/protocols/protocols.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  ValidationError? validate({required String field, required Map input}) {
    ValidationError? error;

    for (final validation in validations.where((v) => v.field == field)) {
      error = validation.validate(input);

      if (error != null) {
        return error;
      }
    }

    return error;
  }
}
