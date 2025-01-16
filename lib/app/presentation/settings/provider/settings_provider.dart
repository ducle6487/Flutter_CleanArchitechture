import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/domain/auth/provider/auth_domain_provider.dart';
import 'package:flutter_clean_architechture/app/domain/user/provider/user_domain_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/settings/controller/settings_view_controller.dart';

class SettingsViewProvider {
  SettingsViewProvider._();

  /// Provider for [SettingController].
  static final settingsViewControllerProvider =
      StateNotifierProvider<SettingsViewController, SettingsViewState>(
    (ref) {
      return SettingsViewController(
        signOutUsecase: ref.watch(
          AuthDomainProvider.signOutUsecaseProvider,
        ),
        getMyProfileUsecase: ref.watch(
          UserDomainProvider.getMyProfileUsecaseProvider,
        ),
      );
    },
  );
}
