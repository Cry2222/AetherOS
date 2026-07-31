class AetherOSConfig {
  const AetherOSConfig._();

  static const apiBaseUrl = String.fromEnvironment(
    'AETHEROS_API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8000',
  );

  static const useDemoData = bool.fromEnvironment(
    'AETHEROS_USE_DEMO_DATA',
    defaultValue: true,
  );
}
