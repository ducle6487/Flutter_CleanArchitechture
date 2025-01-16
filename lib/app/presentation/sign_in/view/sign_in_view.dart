import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/home/provider/home_view_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/provider/settings_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/controller/sign_in_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/provider/sign_in_view_provider.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/widget/sign_in_app_bar.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/widget/sign_in_content_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/verify/controller/verify_view_controller.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/verify/enum/verify_view_type.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/verify/provider/verify_view_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_images.dart';
import 'package:Flutter_CleanArchitechture/core/authorization/service/authorization_service.dart';
import 'package:Flutter_CleanArchitechture/core/router/enum/router_type.dart';
import 'package:Flutter_CleanArchitechture/core/router/extension/router_extension.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_loading_content_view.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/enum/loading_content_type.dart';

class SignInView extends ConsumerWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(SignInViewProvider.signInViewControllerProvider);

    SignInViewState state =
        ref.watch(SignInViewProvider.signInViewControllerProvider);

    ref.listen(
      SignInViewProvider.signInViewControllerProvider,
      (previous, next) {
        if (previous != next) {
          if (previous == null ||
              previous.isLoading != next.isLoading &&
                  !next.isLoading &&
                  AuthorizationService.instance.isAuthorized) {
            _goToHomeView(context, ref);
          }

          if (previous == null ||
              previous.isUnVerify != next.isUnVerify && next.isUnVerify) {
            _goToVerifyView(context, ref);
          }
        }
      },
    );

    Widget background = Container(
      color: context.appColors.appBarColor,
      child: Column(
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
      ),
    );

    Widget content = Scaffold(
      appBar: state.isLoading ? null : const SignInAppBar(),
      backgroundColor: context.appColors.transparentColor,
      body: state.isLoading
          ? const AdvancedLoadingContentView(
              loadingType: LoadingContentType.signIn,
            )
          : const SignInContentView(),
    );

    return Stack(
      children: [
        background,
        content,
      ],
    );
  }

  void _goToHomeView(BuildContext context, WidgetRef ref) {
    ref
        .watch(HomeViewProvider.homeViewControllerProvider.notifier)
        .resetState();
    ref
        .watch(SettingsViewProvider.settingsViewControllerProvider.notifier)
        .getMyProfile();
    context.openPage(screenType: RouterType.home);
    ref
        .watch(SignInViewProvider.signInViewControllerProvider.notifier)
        .resetState();
  }

  void _goToVerifyView(BuildContext context, WidgetRef ref) {
    SignInViewState state =
        ref.watch(SignInViewProvider.signInViewControllerProvider);
    VerifyViewController controller =
        ref.watch(VerifyViewProvider.verifyViewControllerProvider.notifier);
    controller.viewType = VerifyViewType.fromSignIn;
    controller.email = state.emailTFController.text;
    controller.uuid = state.signInResponseDTO?.uuid;
    controller.password = state.passwordTFController.text;
    context.openPage(screenType: RouterType.verify);
  }
}
