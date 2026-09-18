import '../../../core/network/network_client.dart';
import '../../../core/storage/local_storage.dart';
import 'models/auth_response.dart';

class AuthRepository {
  const AuthRepository({
    required this.networkClient,
    required this.localStorage,
  });

  final NetworkClient networkClient;
  final LocalStorage localStorage;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await networkClient.post(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    final authResponse = AuthResponse.fromJson(response);

    await localStorage.saveSession(
      accessToken: authResponse.accessToken,
      refreshToken: authResponse.refreshToken,
      userId: authResponse.userId,
      email: authResponse.email,
    );

    return authResponse;
  }

  Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    String? fullName,
  }) async {
    return networkClient.post(
      '/auth/signup',
      body: {
        'email': email,
        'password': password,
        if (fullName != null && fullName.trim().isNotEmpty)
          'full_name': fullName.trim(),
      },
    );
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    final token = localStorage.accessToken;

    if (token == null || token.isEmpty) {
      throw const NetworkException(
        message: 'You are not authenticated.',
        statusCode: 401,
      );
    }

    return networkClient.get(
      '/auth/me',
      accessToken: token,
    );
  }

  Future<void> logout() async {
    await localStorage.clearSession();
  }
}