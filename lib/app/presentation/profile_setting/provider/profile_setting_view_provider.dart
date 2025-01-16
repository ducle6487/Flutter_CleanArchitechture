import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/provider/user_domain_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/controller/profile_setting_view_controller.dart';

class ProfileSettingViewProvider {
  ProfileSettingViewProvider._();

  /// Provider for [ProfileSettingViewController].
  static final profileSettingViewProvider = StateNotifierProvider<
      ProfileSettingViewController, ProfileSettingViewState>(
    (ref) {
      return ProfileSettingViewController(
        getMyProfileUsecase: ref.watch(
          UserDomainProvider.getMyProfileUsecaseProvider,
        ),
        updateMyProfileUsecase: ref.watch(
          UserDomainProvider.updateMyProfileUsecaseProvider,
        ),
        deleteAccountUsecase: ref.watch(
          UserDomainProvider.deleteAccountUsecaseProvider,
        ),
      );
    },
  );
}
