class AppLanguage {
  final String code;
  final String name;
  final String nativeName;

  const AppLanguage({
    required this.code,
    required this.name,
    required this.nativeName,
  });
}

const List<AppLanguage> supportedLanguages = [
  AppLanguage(code: 'en', name: 'English', nativeName: 'English'),
  AppLanguage(code: 'es', name: 'Spanish', nativeName: 'Español'),
  AppLanguage(code: 'fr', name: 'French', nativeName: 'Français'),
  AppLanguage(code: 'de', name: 'German', nativeName: 'Deutsch'),
]; 