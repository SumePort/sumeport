import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/network/network_client.dart';
import '../../../core/storage/local_storage.dart';
import '../data/auth_repository.dart';
import '../data/models/auth_response.dart';

enum AuthStatus {
  initial,
  checking,
  authenticated,
  unauthenticated,
  verificationRequired,
}

class AuthState {
  const AuthState({
    required this.status,
    this.user,
    this.message,
  });

  const AuthState.initial()
      : status = AuthStatus.initial,
        user = null,
        message = null;

  const AuthState.checking()
      : status = AuthStatus.checking,
        user = null,
        message = null;

  const AuthState.authenticated(AuthResponse this.user)
      : status = AuthStatus.authenticated,
        message = null;

  const AuthState.unauthenticated({
    this.message,
  })  : status = AuthStatus.unauthenticated,
        user = null;

  const AuthState.verificationRequired({
    this.message,
  })  : status = AuthStatus.verificationRequired,
        user = null;

  final AuthStatus status;
  final AuthResponse? user;
  final String? message;
}

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _repository;

  @override
  AuthState build() {
    final preferences = ref.watch(sharedPreferencesProvider);

    final storage = LocalStorage(preferences);

    final networkClient = const NetworkClient(
      baseUrl: 'http://127.0.0.1:8000/api/v1',
    );

    _repository = AuthRepository(
      networkClient: networkClient,
      localStorage: storage,
    );

    Future.microtask(_restoreSession);

    return const AuthState.initial();
  }

  Future<void> _restoreSession() async {
    state = const AuthState.checking();

    try {
      final storedToken = await _getAccessToken();

      if (storedToken == null || storedToken.isEmpty) {
        state = const AuthState.unauthenticated();
        return;
      }

      final currentUser = await _repository.getCurrentUser();

      final emailVerified =
          currentUser['email_verified'] as bool? ?? false;

      final storedUserId = currentUser['user_id'] as String?;
      final storedEmail = currentUser['email'] as String?;

      if (!emailVerified) {
        state = const AuthState.verificationRequired(
          message: 'Please verify your email before continuing.',
        );
        return;
      }

      if (storedUserId == null || storedEmail == null) {
        await _repository.logout();
        state = const AuthState.unauthenticated(
          message: 'Your session is incomplete. Please sign in again.',
        );
        return;
      }

      state = AuthState.authenticated(
        AuthResponse(
          accessToken: storedToken,
          refreshToken: await _getRefreshToken(),
          userId: storedUserId,
          email: storedEmail,
          emailVerified: emailVerified,
        ),
      );
    } on NetworkException catch (error) {
      await _repository.logout();

      state = AuthState.unauthenticated(
        message: error.message,
      );
    } catch (_) {
      await _repository.logout();

      state = const AuthState.unauthenticated(
        message: 'Your session could not be restored.',
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.checking();

    try {
      final response = await _repository.login(
        email: email.trim(),
        password: password,
      );

      if (!response.emailVerified) {
        state = const AuthState.verificationRequired(
          message: 'Please verify your email before continuing.',
        );
        return;
      }

      state = AuthState.authenticated(response);
    } on NetworkException catch (error) {
      state = AuthState.unauthenticated(
        message: error.message,
      );
    } catch (_) {
      state = const AuthState.unauthenticated(
        message: 'Unable to sign in. Please try again.',
      );
    }
  }

  Future<void> signup({
    required String email,
    required String password,
    String? fullName,
  }) async {
    state = const AuthState.checking();

    try {
      await _repository.signup(
        email: email.trim(),
        password: password,
        fullName: fullName?.trim(),
      );

      state = const AuthState.verificationRequired(
        message:
            'Account created successfully. Please check your email to verify your account.',
      );
    } on NetworkException catch (error) {
      state = AuthState.unauthenticated(
        message: error.message,
      );
    } catch (_) {
      state = const AuthState.unauthenticated(
        message: 'Unable to create your account. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const AuthState.unauthenticated();
  }

  Future<String?> _getAccessToken() async {
    final preferences = ref.read(sharedPreferencesProvider);
    final storage = LocalStorage(preferences);

    return storage.accessToken;
  }

  Future<String?> _getRefreshToken() async {
    final preferences = ref.read(sharedPreferencesProvider);
    final storage = LocalStorage(preferences);

    return storage.refreshToken;
  }
}

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main.dart',
  );
});

final authProvider =
    NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);