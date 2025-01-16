import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/provider/auth_domain_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_up/controller/sign_up_view_controller.dart';

class SignUpViewProvider {
  SignUpViewProvider._();

  /// Provider for [SignUpViewController].
  static final signUpViewControllerProvider =
      StateNotifierProvider<SignUpViewController, SignUpViewState>(
    (ref) {
      return SignUpViewController(
        signUpUsecase: ref.watch(
          AuthDomainProvider.signUpUsecaseProvider,
        ),
      );
    },
  );
}
