import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/domain/auth/provider/auth_domain_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/controller/sign_in_view_controller.dart';

class SignInViewProvider {
  SignInViewProvider._();

  /// Provider for [SignInViewController].
  static final signInViewControllerProvider =
      StateNotifierProvider<SignInViewController, SignInViewState>((ref) {
    return SignInViewController(
      signInUsecase: ref.watch(AuthDomainProvider.signInUsecaseProvider),
    );
  });
}
