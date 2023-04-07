import 'package:expensemanagerapp/presentation/protocols/validation.dart';
import 'package:expensemanagerapp/validation/protocols/field_validation.dart';
import 'package:mocktail/mocktail.dart';

class FieldValidationSpy extends Mock implements FieldValidation {
  FieldValidationSpy() {
    mockValidation();
    mockFieldName('any_field');
  }

  When mockValidationCall() => when(() => validate(any()));
  void mockValidation() => mockValidationCall().thenReturn(null);
  void mockValidationError(ValidationError error) =>
      mockValidationCall().thenReturn(error);

  void mockFieldName(String fieldName) =>
      when(() => field).thenReturn(fieldName);
}
