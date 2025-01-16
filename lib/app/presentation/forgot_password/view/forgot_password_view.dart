import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:Flutter_CleanArchitechture/config/app_images.dart';
import 'package:Flutter_CleanArchitechture/core/router/extension/router_extension.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_loading_content_view.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/enum/loading_content_type.dart';
import '../../../../core/router/enum/router_type.dart';
import '../../../../core/dialog/dialog_service.dart';
import '../controller/forgot_password_view_controller.dart';
import '../enum/forgot_password_view_type.dart';
import '../provider/forgot_password_view_provider.dart';
import '../widget/forgot_password_app_bar.dart';
import '../widget/forgot_password_content_view.dart';

class ForgotPasswordView extends ConsumerWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ForgotPasswordViewController controller = ref.watch(
        ForgotPasswordViewProvider
            .forgotPasswordViewControllerProvider.notifier);
    ForgotPasswordViewState state = ref
        .watch(ForgotPasswordViewProvider.forgotPasswordViewControllerProvider);

    Future<void> handleBackAction() async {
      controller.resetState();
      if (state.viewType == ForgotPasswordViewType.selectMethod) {
        context.closePage();
      }
    }

    ref.listen(
      ForgotPasswordViewProvider.forgotPasswordViewControllerProvider,
      (previous, next) {
        if (next.isSuccess) {
          DialogService().forgotPasswordResetSuccessDialog(
            onPressed: () async {
              goToSignInScreen(context, ref);
            },
          );
        }
      },
    );

    Widget background = Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image(
          image: AppImages.signInTopPart.asset,
          width: Get.width,
          fit: BoxFit.fill,
        ),
        Image(
          image: AppImages.signInBottomPart.asset,
          width: Get.width,
          fit: BoxFit.fill,
        ),
      ],
    );

    Widget view = state.isLoading
        ? const AdvancedLoadingContentView(
            loadingType: LoadingContentType.forgotPassword,
          )
        : const ForgotPasswordContentView();

    Widget content = Scaffold(
      appBar: state.isLoading
          ? null
          : ForgotPasswordAppBar(
              onTap: handleBackAction,
            ),
      backgroundColor: context.appColors.backgroundColor,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: context.appColors.backgroundColor,
        child: view,
      ),
    );

    return Container(
      color: context.appColors.appBarColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          background,
          content,
        ],
      ),
    );
  }

  void goToSignInScreen(BuildContext context, WidgetRef ref) {
    ref
        .watch(ForgotPasswordViewProvider
            .forgotPasswordViewControllerProvider.notifier)
        .resetState();
    context.goNamed(RouterType.signIn.name);
  }
}
