// lib/core/constants/api_config.dart

abstract final class ApiConfig {
  const ApiConfig._();

  /// SumePort FastAPI backend base URL.
  ///
  /// Can be overridden at build/run time:
  /// ```bash
  /// flutter run --dart-define=API_BASE_URL=http://127.0.0.1:8000/api/v1
  /// ```
  static const baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://127.0.0.1:8000/api/v1',
  );
}
