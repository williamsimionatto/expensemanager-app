import 'package:equatable/equatable.dart';
import 'package:expensemanagerapp/presentation/protocols/validation.dart';
import 'package:expensemanagerapp/validation/protocols/protocols.dart';

class MinLengthValidation extends Equatable implements FieldValidation {
  final int size;
  @override
  final String field;

  @override
  List get props => [size, field];

  const MinLengthValidation({required this.size, required this.field});

  @override
  ValidationError? validate(Map input) {
    return input[field] != null && input[field].length >= size
        ? null
        : ValidationError.invalidField;
  }
}
