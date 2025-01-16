import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_clean_architechture/app/presentation/home/provider/home_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/settings/provider/settings_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_in/provider/sign_in_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/controller/verify_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/enum/verify_view_type.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/provider/verify_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/widget/verify_app_bar.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/widget/verify_content_view.dart';
import 'package:flutter_clean_architechture/config/app_images.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter_clean_architechture/core/router/extension/router_extension.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_loading_content_view.dart';
import 'package:flutter_clean_architechture/core/widgets/enum/loading_content_type.dart';

class VerifyView extends ConsumerWidget {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    VerifyViewState state =
        ref.watch(VerifyViewProvider.verifyViewControllerProvider);

    ref.listen(
      VerifyViewProvider.verifyViewControllerProvider,
      (previous, next) {
        if ((previous == null || previous.isFailure != next.isFailure) &&
            next.isFailure) {
          DialogService().wrongOTPDialog();
        }

        if ((previous == null || previous.isSuccess != next.isSuccess) &&
            next.isSuccess) {
          _goToNextView(ref, context);
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

    Widget content = Scaffold(
      appBar: const VerifyAppBar(),
      backgroundColor: context.appColors.backgroundColor,
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: state.isLoading
            ? const AdvancedLoadingContentView(
                loadingType: LoadingContentType.verify,
              )
            : const VerifyContentView(),
      ),
    );

    return Container(
      color: context.appColors.backgroundColor,
      child: Stack(
        children: [
          background,
          content,
        ],
      ),
    );
  }

  void _goToNextView(WidgetRef ref, BuildContext context) {
    VerifyViewState state =
        ref.read(VerifyViewProvider.verifyViewControllerProvider);

    if (state.viewType == VerifyViewType.fromSignIn) {
      if (AuthorizationService.instance.isAuthorized) {
        _goToHomeView(context, ref);
      }
    } else {
      ref
          .watch(SignInViewProvider.signInViewControllerProvider.notifier)
          .resetState();
      _goToSignInView(context, ref);
    }
  }

  void _goToHomeView(BuildContext context, WidgetRef ref) {
    ref
        .watch(
          SettingsViewProvider.settingsViewControllerProvider.notifier,
        )
        .getMyProfile();
    ref
        .watch(HomeViewProvider.homeViewControllerProvider.notifier)
        .resetState();
    ref
        .watch(SignInViewProvider.signInViewControllerProvider.notifier)
        .resetState();
    context.openPage(screenType: RouterType.home);
  }

  void _goToSignInView(BuildContext context, WidgetRef ref) {
    ref
        .watch(SignInViewProvider.signInViewControllerProvider.notifier)
        .resetState();
    context.openPage(screenType: RouterType.signIn);
  }
}
