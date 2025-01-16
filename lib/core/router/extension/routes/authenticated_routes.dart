import 'package:flutter_clean_architechture/app/presentation/profile_setting/view/profile_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/app/presentation/change_password/view/change_password_view.dart';
import 'package:flutter_clean_architechture/app/presentation/home/view/home_view.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/view/notification_history_view.dart';
import 'package:flutter_clean_architechture/app/presentation/settings/view/settings_view.dart';
import 'package:flutter_clean_architechture/app/presentation/settings_language/view/settings_language_view.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';

GoRoute authenticatedRoutes() => GoRoute(
      name: RouterType.home.name,
      path: RouterType.home.path,
      builder: (BuildContext context, GoRouterState state) => const HomeView(),
      routes: [
        GoRoute(
          path: RouterType.setting.path,
          name: RouterType.setting.name,
          builder: (context, state) => const SettingsView(),
          routes: [
            GoRoute(
              path: RouterType.languageSettings.path,
              name: RouterType.languageSettings.name,
              builder: (context, state) => const SettingsLanguageView(),
            ),
            GoRoute(
              path: RouterType.profileSetting.path,
              name: RouterType.profileSetting.name,
              builder: (context, state) => const ProfileSettingView(),
              routes: [
                GoRoute(
                  path: RouterType.changePassword.path,
                  name: RouterType.changePassword.name,
                  builder: (context, state) => const ChangePasswordView(),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: RouterType.notificationHistory.path,
          name: RouterType.notificationHistory.name,
          builder: (context, state) => const NotificationHistoryView(),
        ),
      ],
    );
