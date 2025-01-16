enum RouterType {
  home('/home', 'home'),
  launch('/launch', 'launch'),
  signIn('sign-in', 'sign-in'),
  languageSettings('language-setting', 'language-settings'),
  signUp('sign-up', 'sign-up'),
  welcome('/welcome', 'welcome'),
  verify('verify', 'verify'),
  profileSetting('profile-setting', 'profile-setting'),
  changePassword('change-password', 'change-password'),
  forgotPassword('forgot-password', 'forgot-password'),
  setting('setting', 'setting'),
  notificationHistory('notification-history', 'notification-history'),
  ;

  final String path;

  final String name;

  const RouterType(this.path, this.name);
}
