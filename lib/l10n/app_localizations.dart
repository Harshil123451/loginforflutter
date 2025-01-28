import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      'profile': 'Profile',
      'dashboard': 'Dashboard',
      'settings': 'Settings',
      'changePassword': 'Change Password',
      'language': 'Language',
      'notifications': 'Notifications',
      'privacySettings': 'Privacy Settings',
      'logout': 'Logout',
      'createTicket': 'Create Ticket',
      'viewTickets': 'View Tickets',
      'map': 'Map',
      'welcome': 'Welcome',
      'login': 'Login',
      'signup': 'Sign Up',
      'email': 'Email',
      'password': 'Password',
      'fullName': 'Full Name',
      'phone': 'Phone',
      'editProfile': 'Edit Profile',
      'save': 'Save',
      'cancel': 'Cancel',
      'teamChat': 'Team Chat',
      'recentActivities': 'Recent Activities',
      'quickActions': 'Quick Actions',
      'performance': 'Performance',
      'completed': 'Completed',
      'tasks': 'Tasks',
      'pending': 'Pending',
      'reviews': 'Reviews',
      'personalInfo': 'Personal Information',
      'accountSettings': 'Account Settings',
      'currentPassword': 'Current Password',
      'newPassword': 'New Password',
      'confirmPassword': 'Confirm Password',
      'submit': 'Submit',
      'selectLocation': 'Select Location',
      'ticketTitle': 'Ticket Title',
      'ticketMessage': 'Message',
      'location': 'Location',
      'updateLocation': 'Update Location',
      'analytics': 'Analytics',
      'noTicketsYet': 'No tickets yet',
      'pleaseEnterYourEmail': 'Please enter your email',
      'pleaseEnterAValidEmail': 'Please enter a valid email',
      'enterOTP': 'Enter OTP',
      'pleaseEnterOTP': 'Please enter OTP',
      'otpMustBe6Digits': 'OTP must be 6 digits',
      'pleaseEnterCurrentPassword': 'Please enter current password',
      'pleaseEnterNewPassword': 'Please enter new password',
      'passwordMustBeAtLeast6Characters': 'Password must be at least 6 characters',
      'pleaseConfirmYourPassword': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',
      'sendOTP': 'Send OTP',
      'verifyOTP': 'Verify OTP',
      'message': 'Message',
    },
    'es': {
      'profile': 'Perfil',
      'dashboard': 'Panel',
      'settings': 'Ajustes',
      'changePassword': 'Cambiar Contraseña',
      'language': 'Idioma',
      'notifications': 'Notificaciones',
      'privacySettings': 'Configuración de Privacidad',
      'logout': 'Cerrar Sesión',
      'createTicket': 'Crear Ticket',
      'viewTickets': 'Ver Tickets',
      'map': 'Mapa',
      'welcome': 'Bienvenido',
      'login': 'Iniciar Sesión',
      'signup': 'Registrarse',
      'email': 'Correo Electrónico',
      'password': 'Contraseña',
      'fullName': 'Nombre Completo',
      'phone': 'Teléfono',
      'editProfile': 'Editar Perfil',
      'save': 'Guardar',
      'cancel': 'Cancelar',
      'teamChat': 'Chat de Equipo',
      'recentActivities': 'Actividades Recientes',
      'quickActions': 'Acciones Rápidas',
      'performance': 'Rendimiento',
      'completed': 'Completado',
      'tasks': 'Tareas',
      'pending': 'Pendiente',
      'reviews': 'Revisiones',
      'personalInfo': 'Información Personal',
      'accountSettings': 'Configuración de la Cuenta',
      'currentPassword': 'Contraseña Actual',
      'newPassword': 'Nueva Contraseña',
      'confirmPassword': 'Confirmar Contraseña',
      'submit': 'Enviar',
      'selectLocation': 'Seleccionar Ubicación',
      'ticketTitle': 'Título del Ticket',
      'ticketMessage': 'Mensaje',
      'location': 'Ubicación',
      'updateLocation': 'Actualizar Ubicación',
      'analytics': 'Análisis',
      'noTicketsYet': 'No hay tickets aún',
      'pleaseEnterYourEmail': 'Por favor ingrese su correo electrónico',
      'pleaseEnterAValidEmail': 'Por favor ingrese un correo electrónico válido',
      'enterOTP': 'Ingrese OTP',
      'pleaseEnterOTP': 'Por favor ingrese OTP',
      'otpMustBe6Digits': 'OTP debe tener 6 dígitos',
      'pleaseEnterCurrentPassword': 'Por favor ingrese la contraseña actual',
      'pleaseEnterNewPassword': 'Por favor ingrese nueva contraseña',
      'passwordMustBeAtLeast6Characters': 'La contraseña debe tener al menos 6 caracteres',
      'pleaseConfirmYourPassword': 'Por favor confirme su contraseña',
      'passwordsDoNotMatch': 'Las contraseñas no coinciden',
      'sendOTP': 'Enviar OTP',
      'verifyOTP': 'Verificar OTP',
      'message': 'Mensaje',
    },
    'fr': {
      'profile': 'Profil',
      'dashboard': 'Tableau de Bord',
      'settings': 'Paramètres',
      'changePassword': 'Changer le Mot de Passe',
      'language': 'Langue',
      'notifications': 'Notifications',
      'privacySettings': 'Paramètres de Confidentialité',
      'logout': 'Déconnexion',
      'createTicket': 'Créer un Ticket',
      'viewTickets': 'Voir les Tickets',
      'map': 'Carte',
      'welcome': 'Bienvenue',
      'login': 'Connexion',
      'signup': 'Inscription',
      'email': 'Email',
      'password': 'Mot de Passe',
      'fullName': 'Nom Complet',
      'phone': 'Téléphone',
      'editProfile': 'Modifier le Profil',
      'save': 'Enregistrer',
      'cancel': 'Annuler',
      'teamChat': 'Chat d\'Équipe',
      'recentActivities': 'Activités Récentes',
      'quickActions': 'Actions Rapides',
      'performance': 'Performance',
      'completed': 'Terminé',
      'tasks': 'Tâches',
      'pending': 'En Attente',
      'reviews': 'Revues',
      'personalInfo': 'Informations Personnelles',
      'accountSettings': 'Paramètres du Compte',
      'currentPassword': 'Mot de Passe Actuel',
      'newPassword': 'Nouveau Mot de Passe',
      'confirmPassword': 'Confirmer le Mot de Passe',
      'submit': 'Soumettre',
      'selectLocation': 'Sélectionner l\'Emplacement',
      'ticketTitle': 'Titre du Ticket',
      'ticketMessage': 'Message',
      'location': 'Emplacement',
      'updateLocation': 'Mettre à Jour l\'Emplacement',
      'analytics': 'Analytique',
      'noTicketsYet': 'Pas encore de tickets',
      'pleaseEnterYourEmail': 'Veuillez entrer votre email',
      'pleaseEnterAValidEmail': 'Veuillez entrer un email valide',
      'enterOTP': 'Enter OTP',
      'pleaseEnterOTP': 'Veuillez entrer OTP',
      'otpMustBe6Digits': 'OTP doit comporter 6 chiffres',
      'pleaseEnterCurrentPassword': 'Veuillez entrer le mot de passe actuel',
      'pleaseEnterNewPassword': 'Veuillez entrer le nouveau mot de passe',
      'passwordMustBeAtLeast6Characters': 'Le mot de passe doit comporter au moins 6 caractères',
      'pleaseConfirmYourPassword': 'Veuillez confirmer votre mot de passe',
      'passwordsDoNotMatch': 'Les mots de passe ne correspondent pas',
      'sendOTP': 'Send OTP',
      'verifyOTP': 'Verify OTP',
      'message': 'Message',
    },
    'de': {
      'profile': 'Profil',
      'dashboard': 'Dashboard',
      'settings': 'Einstellungen',
      'changePassword': 'Passwort ändern',
      'language': 'Sprache',
      'notifications': 'Benachrichtigungen',
      'privacySettings': 'Datenschutzeinstellungen',
      'logout': 'Abmelden',
      'createTicket': 'Ticket erstellen',
      'viewTickets': 'Tickets anzeigen',
      'map': 'Karte',
      'welcome': 'Willkommen',
      'login': 'Anmelden',
      'signup': 'Registrieren',
      'email': 'Email',
      'password': 'Passwort',
      'fullName': 'Vollständiger Name',
      'phone': 'Telefon',
      'editProfile': 'Profil bearbeiten',
      'save': 'Speichern',
      'cancel': 'Abbrechen',
      'teamChat': 'Team-Chat',
      'recentActivities': 'Neue Aktivitäten',
      'quickActions': 'Schnelle Aktionen',
      'performance': 'Leistung',
      'completed': 'Abgeschlossen',
      'tasks': 'Aufgaben',
      'pending': 'Ausstehend',
      'reviews': 'Bewertungen',
      'personalInfo': 'Persönliche Informationen',
      'accountSettings': 'Kontoeinstellungen',
      'currentPassword': 'Aktuelles Passwort',
      'newPassword': 'Neues Passwort',
      'confirmPassword': 'Passwort bestätigen',
      'submit': 'Einreichen',
      'selectLocation': 'Standort auswählen',
      'ticketTitle': 'Ticket-Titel',
      'ticketMessage': 'Nachricht',
      'location': 'Standort',
      'updateLocation': 'Standort aktualisieren',
      'analytics': 'Analytik',
      'noTicketsYet': 'Noch keine Tickets',
      'pleaseEnterYourEmail': 'Bitte geben Sie Ihre E-Mail-Adresse ein',
      'pleaseEnterAValidEmail': 'Bitte geben Sie eine gültige E-Mail-Adresse ein',
      'enterOTP': 'OTP eingeben',
      'pleaseEnterOTP': 'Bitte geben Sie OTP ein',
      'otpMustBe6Digits': 'OTP muss 6 Ziffern lang sein',
      'pleaseEnterCurrentPassword': 'Bitte geben Sie das aktuelle Passwort ein',
      'pleaseEnterNewPassword': 'Bitte geben Sie das neue Passwort ein',
      'passwordMustBeAtLeast6Characters': 'Das Passwort muss mindestens 6 Zeichen lang sein',
      'pleaseConfirmYourPassword': 'Bitte bestätigen Sie Ihr Passwort',
      'passwordsDoNotMatch': 'Die Passwörter stimmen nicht überein',
      'sendOTP': 'Send OTP',
      'verifyOTP': 'Verify OTP',
      'message': 'Nachricht',
    },
  };

  String get profile => _localizedValues[locale.languageCode]?['profile'] ?? _localizedValues['en']!['profile']!;
  String get dashboard => _localizedValues[locale.languageCode]?['dashboard'] ?? _localizedValues['en']!['dashboard']!;
  String get settings => _localizedValues[locale.languageCode]?['settings'] ?? _localizedValues['en']!['settings']!;
  String get changePassword => _localizedValues[locale.languageCode]?['changePassword'] ?? _localizedValues['en']!['changePassword']!;
  String get language => _localizedValues[locale.languageCode]?['language'] ?? _localizedValues['en']!['language']!;
  String get notifications => _localizedValues[locale.languageCode]?['notifications'] ?? _localizedValues['en']!['notifications']!;
  String get privacySettings => _localizedValues[locale.languageCode]?['privacySettings'] ?? _localizedValues['en']!['privacySettings']!;
  String get logout => _localizedValues[locale.languageCode]?['logout'] ?? _localizedValues['en']!['logout']!;
  String get createTicket => _localizedValues[locale.languageCode]?['createTicket'] ?? _localizedValues['en']!['createTicket']!;
  String get viewTickets => _localizedValues[locale.languageCode]?['viewTickets'] ?? _localizedValues['en']!['viewTickets']!;
  String get map => _localizedValues[locale.languageCode]?['map'] ?? _localizedValues['en']!['map']!;
  String get welcome => _localizedValues[locale.languageCode]?['welcome'] ?? _localizedValues['en']!['welcome']!;
  String get login => _localizedValues[locale.languageCode]?['login'] ?? _localizedValues['en']!['login']!;
  String get signup => _localizedValues[locale.languageCode]?['signup'] ?? _localizedValues['en']!['signup']!;
  String get email => _localizedValues[locale.languageCode]?['email'] ?? _localizedValues['en']!['email']!;
  String get password => _localizedValues[locale.languageCode]?['password'] ?? _localizedValues['en']!['password']!;
  String get fullName => _localizedValues[locale.languageCode]?['fullName'] ?? _localizedValues['en']!['fullName']!;
  String get phone => _localizedValues[locale.languageCode]?['phone'] ?? _localizedValues['en']!['phone']!;
  String get editProfile => _localizedValues[locale.languageCode]?['editProfile'] ?? _localizedValues['en']!['editProfile']!;
  String get save => _localizedValues[locale.languageCode]?['save'] ?? _localizedValues['en']!['save']!;
  String get cancel => _localizedValues[locale.languageCode]?['cancel'] ?? _localizedValues['en']!['cancel']!;
  String get teamChat => _localizedValues[locale.languageCode]?['teamChat'] ?? _localizedValues['en']!['teamChat']!;
  String get recentActivities => _localizedValues[locale.languageCode]?['recentActivities'] ?? _localizedValues['en']!['recentActivities']!;
  String get quickActions => _localizedValues[locale.languageCode]?['quickActions'] ?? _localizedValues['en']!['quickActions']!;
  String get performance => _localizedValues[locale.languageCode]?['performance'] ?? _localizedValues['en']!['performance']!;
  String get completed => _localizedValues[locale.languageCode]?['completed'] ?? _localizedValues['en']!['completed']!;
  String get tasks => _localizedValues[locale.languageCode]?['tasks'] ?? _localizedValues['en']!['tasks']!;
  String get pending => _localizedValues[locale.languageCode]?['pending'] ?? _localizedValues['en']!['pending']!;
  String get reviews => _localizedValues[locale.languageCode]?['reviews'] ?? _localizedValues['en']!['reviews']!;
  String get personalInfo => _localizedValues[locale.languageCode]?['personalInfo'] ?? _localizedValues['en']!['personalInfo']!;
  String get accountSettings => _localizedValues[locale.languageCode]?['accountSettings'] ?? _localizedValues['en']!['accountSettings']!;
  String get currentPassword => _localizedValues[locale.languageCode]?['currentPassword'] ?? _localizedValues['en']!['currentPassword']!;
  String get newPassword => _localizedValues[locale.languageCode]?['newPassword'] ?? _localizedValues['en']!['newPassword']!;
  String get confirmPassword => _localizedValues[locale.languageCode]?['confirmPassword'] ?? _localizedValues['en']!['confirmPassword']!;
  String get submit => _localizedValues[locale.languageCode]?['submit'] ?? _localizedValues['en']!['submit']!;
  String get selectLocation => _localizedValues[locale.languageCode]?['selectLocation'] ?? _localizedValues['en']!['selectLocation']!;
  String get ticketTitle => _localizedValues[locale.languageCode]?['ticketTitle'] ?? _localizedValues['en']!['ticketTitle']!;
  String get ticketMessage => _localizedValues[locale.languageCode]?['ticketMessage'] ?? _localizedValues['en']!['ticketMessage']!;
  String get location => _localizedValues[locale.languageCode]?['location'] ?? _localizedValues['en']!['location']!;
  String get updateLocation => _localizedValues[locale.languageCode]?['updateLocation'] ?? _localizedValues['en']!['updateLocation']!;
  String get analytics => _localizedValues[locale.languageCode]?['analytics'] ?? _localizedValues['en']!['analytics']!;
  String get noTicketsYet => _localizedValues[locale.languageCode]?['noTicketsYet'] ?? _localizedValues['en']!['noTicketsYet']!;
  String get pleaseEnterYourEmail => _localizedValues[locale.languageCode]?['pleaseEnterYourEmail'] ?? _localizedValues['en']!['pleaseEnterYourEmail']!;
  String get pleaseEnterAValidEmail => _localizedValues[locale.languageCode]?['pleaseEnterAValidEmail'] ?? _localizedValues['en']!['pleaseEnterAValidEmail']!;
  String get enterOTP => _localizedValues[locale.languageCode]?['enterOTP'] ?? _localizedValues['en']!['enterOTP']!;
  String get pleaseEnterOTP => _localizedValues[locale.languageCode]?['pleaseEnterOTP'] ?? _localizedValues['en']!['pleaseEnterOTP']!;
  String get otpMustBe6Digits => _localizedValues[locale.languageCode]?['otpMustBe6Digits'] ?? _localizedValues['en']!['otpMustBe6Digits']!;
  String get pleaseEnterCurrentPassword => _localizedValues[locale.languageCode]?['pleaseEnterCurrentPassword'] ?? _localizedValues['en']!['pleaseEnterCurrentPassword']!;
  String get pleaseEnterNewPassword => _localizedValues[locale.languageCode]?['pleaseEnterNewPassword'] ?? _localizedValues['en']!['pleaseEnterNewPassword']!;
  String get passwordMustBeAtLeast6Characters => _localizedValues[locale.languageCode]?['passwordMustBeAtLeast6Characters'] ?? _localizedValues['en']!['passwordMustBeAtLeast6Characters']!;
  String get pleaseConfirmYourPassword => _localizedValues[locale.languageCode]?['pleaseConfirmYourPassword'] ?? _localizedValues['en']!['pleaseConfirmYourPassword']!;
  String get passwordsDoNotMatch => _localizedValues[locale.languageCode]?['passwordsDoNotMatch'] ?? _localizedValues['en']!['passwordsDoNotMatch']!;
  String get sendOTP => _localizedValues[locale.languageCode]?['sendOTP'] ?? _localizedValues['en']!['sendOTP']!;
  String get verifyOTP => _localizedValues[locale.languageCode]?['verifyOTP'] ?? _localizedValues['en']!['verifyOTP']!;
  String get message => _localizedValues[locale.languageCode]?['message'] ?? _localizedValues['en']!['message']!;
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'fr', 'de'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
} 