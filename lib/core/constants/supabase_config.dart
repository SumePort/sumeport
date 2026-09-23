class SupabaseConfig {
  const SupabaseConfig._();

  // Pass these at build/run time. Never commit project secrets.
  //
  // Example:
  // flutter run -d chrome \
  //   --dart-define=SUPABASE_URL=https://YOUR_PROJECT.supabase.co \
  //   --dart-define=SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
  static const url = String.fromEnvironment('SUPABASE_URL');
  static const publishableKey =
      String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');

  static bool get isConfigured =>
      url.isNotEmpty && publishableKey.isNotEmpty;
}
