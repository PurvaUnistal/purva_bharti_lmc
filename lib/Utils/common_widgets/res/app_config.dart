class AppConfig {
  static AppConfig? instance;

  static AppConfig? instanceInit() {
    instance ??= AppConfig();
    return instance;
  }
  String _buildName = "";
  String get buildName => _buildName;

  setBuildName({required String name}) {
    _buildName = name;
  }
}