import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/core/error/enum/client/client_exception_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/language_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/client_failure.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/failure.dart';
import 'package:Flutter_CleanArchitechture/core/error/model/server_failure.dart';

class LocalizationState {
  final LanguageType languageType;
  final Locale languageLocale;
  final Map<String, dynamic> translations;
  final bool toggleReload;

  const LocalizationState({
    required this.translations,
    required this.languageLocale,
    required this.languageType,
    required this.toggleReload,
  });

  /// Creates a copy of this class.
  LocalizationState copyWith({
    LanguageType? languageType,
    Locale? languageLocale,
    Map<String, dynamic>? translations,
    bool? toggleReload,
  }) {
    return LocalizationState(
      languageType: languageType ?? this.languageType,
      languageLocale: languageLocale ?? this.languageLocale,
      translations: translations ?? this.translations,
      toggleReload: toggleReload ?? this.toggleReload,
    );
  }
}

class LocalizationController extends StateNotifier<LocalizationState> {
  LocalizationController()
      : super(
          LocalizationState(
            languageType: LanguageType.vietnamese,
            languageLocale: LanguageType.vietnamese.getLocale(),
            translations: {},
            toggleReload: false,
          ),
        );

  /// Setter for [toggleReload].
  set toggleReload(bool? toggleReload) =>
      state = state.copyWith(toggleReload: toggleReload);

  /// Getter for [toggleReload].
  bool get toggleReload => state.toggleReload;

  /// Getter for [languageType].
  LanguageType get languageType => state.languageType;

  /// Changes the language of the app.
  ///
  /// Throws a [ClientFailure] when an error occurs.
  Future<void> changeLanguage({required LanguageType languageType}) async {
    try {
      final String translationJsonString =
          await rootBundle.loadString(languageType.translationFilePath);
      state = state.copyWith(
        languageType: languageType,
        languageLocale: languageType.getLocale(),
        translations: json.decode(translationJsonString),
      );
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.translationUpdateError,
      );
    }
  }

  /// Translates the given [TextType].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  String translateText({required TextType textType}) {
    try {
      return state.translations['application_text']![textType.name];
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.translationNotFoundError,
      );
    }
  }

  /// Translates the given [Failure].
  ///
  /// Throws a [ClientFailure] when an error occurs.
  String translateFailure({required Failure failure}) {
    try {
      if (failure is ServerFailure) {
        return state.translations['server_exception']![
            failure.serverExceptionType.name][failure.serverProblemType.name];
      } else if (failure is ClientFailure) {
        return state.translations['client_exception']![
            failure.clientExceptionType.name];
      }
    } catch (errorOrException) {
      throw ClientFailure(
        stackTrace: StackTrace.current,
        thrownErrorOrException: errorOrException,
        clientExceptionType: ClientExceptionType.translationNotFoundError,
      );
    }

    throw ClientFailure(
      stackTrace: StackTrace.current,
      thrownErrorOrException: null,
      clientExceptionType: ClientExceptionType.unexpectedFailureTypeError,
    );
  }

  void reload() {
    state = state.copyWith(
        languageType: null,
        languageLocale: null,
        translations: null,
        toggleReload: true);
  }
}
