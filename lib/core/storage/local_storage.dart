import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  LocalStorage(this._preferences);

  final SharedPreferences _preferences;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  String? get accessToken {
    return _preferences.getString(_accessTokenKey);
  }

  String? get refreshToken {
    return _preferences.getString(_refreshTokenKey);
  }

  String? get userId {
    return _preferences.getString(_userIdKey);
  }

  String? get userEmail {
    return _preferences.getString(_userEmailKey);
  }

  bool get isAuthenticated {
    final token = accessToken;
    return token != null && token.isNotEmpty;
  }

  Future<void> saveSession({
    required String accessToken,
    String? refreshToken,
    required String userId,
    required String email,
  }) async {
    await _preferences.setString(
      _accessTokenKey,
      accessToken,
    );

    if (refreshToken != null && refreshToken.isNotEmpty) {
      await _preferences.setString(
        _refreshTokenKey,
        refreshToken,
      );
    }

    await _preferences.setString(
      _userIdKey,
      userId,
    );

    await _preferences.setString(
      _userEmailKey,
      email,
    );
  }

  Future<void> clearSession() async {
    await _preferences.remove(_accessTokenKey);
    await _preferences.remove(_refreshTokenKey);
    await _preferences.remove(_userIdKey);
    await _preferences.remove(_userEmailKey);
  }
}