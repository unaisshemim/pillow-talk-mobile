// lib/config/env_config.dart
class EnvConfig {
  static const _env = String.fromEnvironment('ENV');

  static bool get isProd => _env == 'prod';
  static bool get isDev => _env == 'dev';

  static String get baseUrl {
    if (isProd) return 'https://api.production.com';
    return 'https://api.dev.local';
  }

  static String get apiKey {
    if (isProd) return 'prod-KEY-xyz';
    return 'dev-KEY-abc';
  }

  // You can add more keys similarly
}
