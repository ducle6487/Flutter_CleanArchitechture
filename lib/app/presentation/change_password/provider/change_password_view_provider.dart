import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/user/provider/user_domain_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/change_password/controller/change_password_view_controller.dart';

class ChangePasswordViewProvider {
  ChangePasswordViewProvider._();

  /// Provider for [ChangePasswordViewController].
  static final changePasswordViewControllerProvider = StateNotifierProvider<
      ChangePasswordViewController, ChangePasswordViewState>((ref) {
    return ChangePasswordViewController(
      changePasswordUsecase:
          ref.watch(UserDomainProvider.changePasswordUsecaseProvider),
    );
  });
}
