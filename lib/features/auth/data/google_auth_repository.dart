import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleAuthRepository {
  const GoogleAuthRepository();

  Future<bool> signIn() {
    return Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      authScreenLaunchMode: LaunchMode.platformDefault,
    );
  }
}
