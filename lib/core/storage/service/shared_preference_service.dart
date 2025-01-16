import 'package:flutter/material.dart';
import 'package:Flutter_CleanArchitechture/core/log/extension/log_extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Flutter_CleanArchitechture/config/app_config.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/language_type.dart';
import 'package:Flutter_CleanArchitechture/core/storage/Constants/shared_preference_key.dart';

class SharedPreferenceService {
  static SharedPreferences? _sharedPreferences;

  const SharedPreferenceService._();

  /// Creates an instance of this class.
  static Future<void> createInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Setter for [theme].
  static Future<void> setTheme({required ThemeMode themeMode}) async {
    await _sharedPreferences?.setInt(
        SharedPreferencesKey.themeKey.key, themeMode.index);
  }

  /// Getter for [theme].
  static ThemeMode getTheme() {
    final int? index =
        _sharedPreferences?.getInt(SharedPreferencesKey.themeKey.key);

    return ThemeMode.values.firstWhere(
      (element) => element.index == index,
      orElse: () => AppConfig.defaultThemeMode,
    );
  }

  /// Setter for [language].
  static Future<void> setLanguage({required LanguageType languageType}) async {
    await _sharedPreferences?.setInt(
        SharedPreferencesKey.languageKey.key, languageType.index);
  }

  /// Getter for [language].
  static LanguageType getLanguage() {
    final int? index =
        _sharedPreferences?.getInt(SharedPreferencesKey.languageKey.key);

    return LanguageType.values.firstWhere(
      (element) => element.index == index,
      orElse: () => AppConfig.defaultLanguageType,
    );
  }

  /// Setter for [access_token].
  static Future<void> setAccessToken({required String accessToken}) async {
    await _sharedPreferences?.setString(
        SharedPreferencesKey.accessToken.key, accessToken);
  }

  /// Getter for [access_token].
  static String? getAccessToken() {
    final String? accessToken =
        _sharedPreferences?.getString(SharedPreferencesKey.accessToken.key);

    return accessToken;
  }

  /// Setter for [refresh_token].
  static Future<void> setRefreshToken({required String refreshToken}) async {
    await _sharedPreferences?.setString(
      SharedPreferencesKey.refreshToken.key,
      refreshToken,
    );
  }

  /// Getter for [refresh_token].
  static String? getRefreshToken() {
    final String? refreshToken =
        _sharedPreferences?.getString(SharedPreferencesKey.refreshToken.key);

    return refreshToken;
  }

  /// Setter for [fcm_token].
  static Future<void> setFCMToken({required String fcmToken}) async {
    await _sharedPreferences?.setString(
      SharedPreferencesKey.firebaseCloudMessagingToken.key,
      fcmToken,
    );
  }

  /// Getter for [fcm_token].
  static String? getFCMToken() {
    final String? refreshToken = _sharedPreferences?.getString(
      SharedPreferencesKey.firebaseCloudMessagingToken.key,
    );

    return refreshToken;
  }

  static Future<void> clearToken() async {
    await _sharedPreferences?.remove(SharedPreferencesKey.accessToken.key);
    await _sharedPreferences?.remove(SharedPreferencesKey.refreshToken.key);

    StackTrace.current.printSuccessMessage(
      message: 'Clear Authorization token successful',
    );
  }

  /// Clears all key value pairs.
  static Future<void> clear() async {
    await _sharedPreferences?.clear();
  }
}
