import 'package:Flutter_CleanArchitechture/core/theme/constants/dark_theme_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Flutter_CleanArchitechture/core/api/provider/api_provider.dart';
import 'package:Flutter_CleanArchitechture/core/api/service/http_service.dart';
import 'package:Flutter_CleanArchitechture/core/environment/enum/development_environment.dart';
import 'package:Flutter_CleanArchitechture/core/environment/service/environment_service.dart';
import 'package:Flutter_CleanArchitechture/core/firebase/firebase_messaging_service.dart';
import 'package:Flutter_CleanArchitechture/core/internet_connection_service/internet_connection_service.dart';
import 'package:Flutter_CleanArchitechture/core/loading/provider/loading_provider.dart';
import 'package:Flutter_CleanArchitechture/core/loading/widget/loading_lottie_animation.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/language_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/provider/localization_provider.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/notification/service/notification_service.dart';
import 'package:Flutter_CleanArchitechture/core/permission/permission_service.dart';
import 'package:Flutter_CleanArchitechture/core/router/extension/router_extension.dart';
import 'package:Flutter_CleanArchitechture/core/storage/service/shared_preference_service.dart';
import 'package:Flutter_CleanArchitechture/core/theme/constants/light_theme_constants.dart';
import 'package:Flutter_CleanArchitechture/core/theme/provider/theme_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> mainCommon({
  required Environment env,
}) async {
  EnvironmentService.load(env: env);
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app in portrait mode
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  WidgetsFlutterBinding.ensureInitialized();

  final ProviderContainer providerContainer = ProviderContainer();

  await SharedPreferenceService.createInstance();

  final localizationController = providerContainer
      .read(LocalizationProvider.localizationControllerProvider.notifier);
  await localizationController.changeLanguage(
    languageType: SharedPreferenceService.getLanguage(),
  );

  LocalizationService.createInstance(localizationController);

  final themeController =
      providerContainer.read(ThemeProvider.themeControllerProvider.notifier);
  themeController.themeMode = SharedPreferenceService.getTheme();

  final HttpService httpService = await HttpService.createInstance();

  await Firebase.initializeApp();
  FirebaseMessagingService.shared.registerFirebaseMessage();
  FirebaseMessagingService.shared.observeFirebaseMessaging();
  PermissionService.requestLocationPermissions();
  InternetConnectionService.initializeConnectivity();

  runApp(
    ProviderScope(
      overrides: [
        LocalizationProvider.localizationControllerProvider.overrideWith(
          (ref) => localizationController,
        ),
        ThemeProvider.themeControllerProvider.overrideWith(
          (ref) => themeController,
        ),
        ApiProvider.httpServiceProvider.overrideWithValue(
          httpService,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(LoadingProvider.loadingControllerProvider);
    final localizationState =
        ref.watch(LocalizationProvider.localizationControllerProvider);
    final themeState = ref.watch(ThemeProvider.themeControllerProvider);
    NotificationService.shared.ref = ref;

    return LoadingLottieAnimation(
      isLoading: loadingState.isLoading,
      child: GestureDetector(
        onTap: () => {
          // FocusManager.instance.primaryFocus?.unfocus(),
          SystemChannels.textInput.invokeMethod('TextInput.hide'),
        },
        child: MaterialApp.router(
          title: 'Flutter_CleanArchitechture',
          themeMode: themeState.themeMode,
          theme: LightThemeConstants.themeData,
          darkTheme: DarkThemeConstants.themeData,
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (BuildContext context, Widget? child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
            child: Localizations.override(
              context: context,
              locale: localizationState.languageLocale,
              child: child,
            ),
          ),
          supportedLocales: LanguageType.values.map((e) => e.getLocale()),
          locale: localizationState.languageLocale,
          debugShowCheckedModeBanner: false,
          routerConfig: RouterExtension.goRouter,
        ),
      ),
    );
  }
}
