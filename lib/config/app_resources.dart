import 'package:Flutter_CleanArchitechture/core/environment/service/environment_service.dart';

class AppResources {
  const AppResources._();

  static const String termsOfUseUrl = "http://term.ican.com.vn";

  static final String baseUrl = EnvironmentService.apiUrl;

  /// Web certificate paths.
  static const List<String> trustCertificatePaths = [
    'assets/certs/lets-encrypt-r3.pem',
  ];

  /// The file path for the English translation file.
  static const String englishTranslationFilePath =
      'assets/translations/en.json';

  /// The file path for the Turkish translation file.
  static const String vietnameseTranslationFilePath =
      'assets/translations/vn.json';

  static const String lottieLoadingAnimationPath =
      'assets/lottie/loading_animation.json';

  /// specific api base url defined - todo: add more in future when new baseurl available
  static final String authBaseUrl = '$baseUrl/v1/social-life/auth';
  static final String userBaseUrl = '$baseUrl/v1/social-life/user';
  static final String storageBaseUrl = '$baseUrl/v1/social-life/storage';
  static final String notificationBaseUrl =
      '$baseUrl/v1/social-life/notification';
}
