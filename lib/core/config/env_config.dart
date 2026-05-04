class EnvConfig {
  EnvConfig._();

  // ── Base URL da API ───────────────────────────────────────────────────────
  // Prioridade de resolução:
  //   1. BASE_URL  — override total (produção, device físico, CI)
  //   2. http://10.0.2.2:<PORT> — fallback para emulador Android com server local
  static const String _port = String.fromEnvironment(
    'PORT',
    defaultValue: '3000',
  );
  static const String _baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: '',
  );

  static String get baseUrl {
    if (_baseUrl.isNotEmpty) return _baseUrl;
    return 'http://10.0.2.2:$_port';
  }

  // ── Flavor / ambiente ────────────────────────────────────────────────────
  // Valores esperados: 'dev', 'staging', 'prod'
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static bool get isDev => flavor == 'dev';
  static bool get isProd => flavor == 'prod';

  // ── Outros ───────────────────────────────────────────────────────────────
  static const bool isDebug = bool.fromEnvironment(
    'IS_DEBUG',
    defaultValue: true,
  );
}
