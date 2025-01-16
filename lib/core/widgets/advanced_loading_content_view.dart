import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_resources.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_lottie_animation.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/enum/loading_content_type.dart';

class AdvancedLoadingContentView extends ConsumerWidget {
  final LoadingContentType loadingType;

  const AdvancedLoadingContentView({required this.loadingType, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double lottieHeight = MediaQuery.of(context).size.shortestSide / 2.0;

    Widget loadingAnimation = AdvancedLottieAnimation(
      lottieAnimationPath: AppResources.lottieLoadingAnimationPath,
      isLottieAnimationVisible: true,
      animationHeight: lottieHeight,
      containerHeight: AppDimensions.widgetHeight,
      containerWidth: AppDimensions.widgetHeight,
      blurBackground: false,
    );

    Widget loadingText = Padding(
      padding: const EdgeInsets.all(AppSpacings.cozy),
      child: Text(
        _getLoadingText(),
      ),
    );

    Widget loading = Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [loadingAnimation, loadingText],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacings.spacious),
      child: loading,
    );
  }

  String _getLoadingText() {
    return switch (loadingType) {
      LoadingContentType.signIn =>
        LocalizationService.translateText(TextType.signYouIn),
      LoadingContentType.signUp =>
        LocalizationService.translateText(TextType.signUpYouIn),
      LoadingContentType.verify =>
        LocalizationService.translateText(TextType.verifying),
      LoadingContentType.forgotPassword =>
        LocalizationService.translateText(TextType.recovering),
    };
  }
}
