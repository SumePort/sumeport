import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthResponse, LocalStorage;

import '../../../core/network/network_client.dart';
import '../../../core/storage/local_storage.dart';
import '../../../core/constants/supabase_config.dart';
import '../data/auth_repository.dart';
import '../data/models/auth_response.dart';
import '../data/google_auth_repository.dart';

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
  GoogleAuthRepository? _googleRepository;
  StreamSubscription<dynamic>?
      _supabaseAuthSubscription;

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

    if (SupabaseConfig.isConfigured) {
      _googleRepository = const GoogleAuthRepository();

      _supabaseAuthSubscription = Supabase
          .instance.client.auth.onAuthStateChange
          .listen(
        (data) {
          final session = data.session;
          if (session != null) {
            unawaited(_syncSupabaseSession(session));
          } else if (data.event == AuthChangeEvent.signedOut) {
            unawaited(storage.clearSession());
          }
        },
        onError: (_, __) {},
      );

      ref.onDispose(() {
        unawaited(
          _supabaseAuthSubscription?.cancel() ??
              Future<void>.value(),
        );
      });
    }

    Future.microtask(_restoreSession);

    return const AuthState.initial();
  }

  Future<void> _restoreSession() async {
    state = const AuthState.checking();

    try {
      if (SupabaseConfig.isConfigured) {
        final session = Supabase.instance.client.auth.currentSession;

        if (session != null && !session.isExpired) {
          await _syncSupabaseSession(session);
          return;
        }
      }

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

  Future<void> _syncSupabaseSession(Session session) async {
    try {
      final user = session.user;
      final email = user.email;

      if (email == null || email.isEmpty) {
        state = const AuthState.unauthenticated(
          message: 'Google did not provide an email address.',
        );
        return;
      }

      final emailVerified = user.emailConfirmedAt != null;

      final preferences = ref.read(sharedPreferencesProvider);
      final storage = LocalStorage(preferences);

      await storage.saveSession(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken,
        userId: user.id,
        email: email,
      );

      state = AuthState.authenticated(
        AuthResponse(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
          userId: user.id,
          email: email,
          emailVerified: emailVerified,
          provider: 'google',
        ),
      );
    } catch (_) {
      state = const AuthState.unauthenticated(
        message: 'Unable to finish Google sign-in. Please try again.',
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

  Future<void> signInWithGoogle() async {
    if (!SupabaseConfig.isConfigured || _googleRepository == null) {
      state = const AuthState.unauthenticated(
        message:
            'Google sign-in is not configured in this build. '
            'Run Flutter with the SumePort Supabase dart-defines.',
      );
      return;
    }

    state = const AuthState.checking();

    try {
      final started = await _googleRepository!.signIn();

      if (!started) {
        state = const AuthState.unauthenticated(
          message: 'Google sign-in could not be started.',
        );
      }
      // OAuth redirects to Google. The Supabase auth listener above
      // completes the session when the user returns to SumePort.
    } on AuthException catch (error) {
      state = AuthState.unauthenticated(
        message: error.message,
      );
    } catch (_) {
      state = const AuthState.unauthenticated(
        message: 'Unable to start Google sign-in. Please try again.',
      );
    }
  }

  Future<void> logout() async {
    if (SupabaseConfig.isConfigured) {
      try {
        await Supabase.instance.client.auth.signOut();
      } catch (_) {
        // Local session is still cleared below.
      }
    }

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

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider must be overridden in main.dart',
  );
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
