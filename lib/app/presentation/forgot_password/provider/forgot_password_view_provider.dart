import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/auth/provider/auth_domain_provider.dart';
import '../controller/forgot_password_view_controller.dart';

class ForgotPasswordViewProvider {
  ForgotPasswordViewProvider._();

  /// Provider for [ForgotPasswordViewController].
  static final forgotPasswordViewControllerProvider = StateNotifierProvider<
      ForgotPasswordViewController, ForgotPasswordViewState>(
    (ref) {
      return ForgotPasswordViewController(
        forgotPasswordUsecase:
            ref.watch(AuthDomainProvider.forgotPasswordUsecaseProvider),
      );
    },
  );
}
