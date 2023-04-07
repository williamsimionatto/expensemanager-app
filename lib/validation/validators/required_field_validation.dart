import 'package:equatable/equatable.dart';
import 'package:expensemanagerapp/presentation/protocols/validation.dart';
import 'package:expensemanagerapp/validation/protocols/protocols.dart';

class RequiredFieldValidation extends Equatable implements FieldValidation {
  @override
  final String field;

  @override
  List get props => [field];

  const RequiredFieldValidation(this.field);

  @override
  ValidationError? validate(Map input) {
    return input[field]?.isNotEmpty == true
        ? null
        : ValidationError.requiredField;
  }
}
