const env = String.fromEnvironment('FLUTTER_ENV', defaultValue: 'production');

const _backendHost = String.fromEnvironment('API_HOST', defaultValue: '/');
final apiBaseUrl = Uri.parse(_backendHost).resolve('api/').toString();
