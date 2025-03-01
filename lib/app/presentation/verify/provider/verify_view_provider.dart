import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/domain/auth/provider/auth_domain_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/controller/verify_view_controller.dart';

class VerifyViewProvider {
  VerifyViewProvider._();

  /// Provider for [VerifyViewController].
  static final verifyViewControllerProvider =
      StateNotifierProvider<VerifyViewController, VerifyViewState>(
    (ref) {
      return VerifyViewController(
        verifyUsecase: ref.watch(
          AuthDomainProvider.verifyUsecaseProvider,
        ),
        resentOTPUsecase: ref.watch(
          AuthDomainProvider.resentOTPUsecaseProvider,
        ),
        signInUsecase: ref.watch(
          AuthDomainProvider.signInUsecaseProvider,
        ),
      );
    },
  );
}
