import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/storage/local_storage.dart';

class GoogleAuthRepository {
  const GoogleAuthRepository({
    required this.localStorage,
  });

  final LocalStorage localStorage;

  Future<bool> signIn() {
    return Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      authScreenLaunchMode: LaunchMode.platformDefault,
    );
  }
}
