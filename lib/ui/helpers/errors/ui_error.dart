enum UIError { requiredField, invalidField, unexpected }

extension UIErrorExtension on UIError {
  String get description {
    switch (this) {
      case UIError.requiredField:
        return 'Campo obrigatório';
      case UIError.invalidField:
        return 'Campo inválido';
      case UIError.unexpected:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
