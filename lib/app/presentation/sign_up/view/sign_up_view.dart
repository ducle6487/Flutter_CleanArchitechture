import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/controller/sign_up_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/provider/sign_up_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/widget/sign_up_app_bar.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/widget/sign_up_content_view.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/controller/verify_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/enum/verify_view_type.dart';
import 'package:flutter_clean_architechture/app/presentation/verify/provider/verify_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_images.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter_clean_architechture/core/router/extension/router_extension.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_loading_content_view.dart';
import 'package:flutter_clean_architechture/core/widgets/enum/loading_content_type.dart';

class SignUpView extends ConsumerWidget {
  const SignUpView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SignUpViewState state =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider);

    ref.listen(
      SignUpViewProvider.signUpViewControllerProvider,
      (previous, next) {
        if (previous == null ||
            previous.isSuccess != next.isSuccess && next.isSuccess) {
          DialogService().signUpSuccessDialog(
            onPressed: () async {
              _goToVerifyView(context, ref);
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

    Widget content = Scaffold(
      appBar: state.isLoading ? null : const SignUpAppBar(),
      backgroundColor: context.appColors.transparentColor,
      body: Container(
        width: Get.width,
        height: Get.height,
        color: context.appColors.transparentColor,
        child: state.isLoading
            ? const AdvancedLoadingContentView(
                loadingType: LoadingContentType.signUp,
              )
            : const SignUpContentView(),
      ),
    );

    return Container(
      color: context.appColors.appBarColor,
      child: Stack(
        children: [
          background,
          content,
        ],
      ),
    );
  }

  void _goToVerifyView(BuildContext context, WidgetRef ref) {
    SignUpViewState state =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider);
    SignUpViewController signUpViewController =
        ref.watch(SignUpViewProvider.signUpViewControllerProvider.notifier);
    VerifyViewController controller =
        ref.watch(VerifyViewProvider.verifyViewControllerProvider.notifier);
    controller.viewType = VerifyViewType.fromSignUp;
    controller.email = state.emailTFController.text;
    controller.uuid = state.uuid;
    signUpViewController.resetState();
    context.openPage(screenType: RouterType.verify);
  }
}
