enum DomainError {
  unexpected,
  invalidCredentials,
  emailInUse,
  accessDenied,
  unprocessable
}

extension DomainErrorExtesion on DomainError {
  String get description {
    switch (this) {
      default:
        return 'Algo errado aconteceu. Tente novamente em breve.';
    }
  }
}
