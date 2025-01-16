enum SharedPreferencesKey {
  themeKey('theme'),
  languageKey('language'),
  accessToken('access_token'),
  refreshToken('refresh_token'),
  firebaseCloudMessagingToken('fcm_token'),
  ;

  const SharedPreferencesKey(this.key);
  final String key;
}
