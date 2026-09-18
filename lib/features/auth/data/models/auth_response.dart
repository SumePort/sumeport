class AuthResponse {
  const AuthResponse({
    required this.accessToken,
    this.refreshToken,
    required this.userId,
    required this.email,
    required this.emailVerified,
  });

  final String accessToken;
  final String? refreshToken;
  final String userId;
  final String email;
  final bool emailVerified;

  factory AuthResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return AuthResponse(
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String?,
      userId: json['user_id'] as String,
      email: json['email'] as String,
      emailVerified:
          json['email_verified'] as bool? ?? false,
    );
  }
}