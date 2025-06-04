class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'This email address is already in use.',
    'OPERATION_NOT_ALLOWED': 'Operation not allowed.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Too many attempts, please try again later.',
    'EMAIL_NOT_FOUND': 'No user found with this email.',
    'INVALID_PASSWORD': 'Invalid password.',
    'USER_DISABLED': 'This user has been disabled.',
    'INVALID_LOGIN_CREDENTIALS':
        'Email or password is incorrect.', // <-- Adicionado
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'An unknown error occurred.';
  }
}
