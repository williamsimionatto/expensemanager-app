import 'package:expensemanagerapp/presentation/protocols/protocols.dart';

abstract class FieldValidation {
  String get field;
  ValidationError? validate(Map input);
}
