enum UIError { requiredField, invalidField, unexpected }

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Required Field';
      case UIError.invalidField:
        return 'Invalid Field';
      case UIError.unexpected:
        return 'Something went wrong. Please try again soon.';
    }
  }
}
