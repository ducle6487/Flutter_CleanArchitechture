import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_resources.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_lottie_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingLottieAnimation extends ConsumerStatefulWidget {
  final bool isLoading;
  final Widget child;

  const LoadingLottieAnimation({
    super.key,
    required this.isLoading,
    required this.child,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoadingLottieAnimationState();
}

class _LoadingLottieAnimationState extends ConsumerState<LoadingLottieAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);

    _controller?.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        _controller?.repeat();
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double lottieHeight = AppDimensions.lottieHeight;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        widget.child,
        AdvancedLottieAnimation(
          lottieAnimationPath: AppResources.lottieLoadingAnimationPath,
          isLottieAnimationVisible: widget.isLoading,
          controller: _controller,
          animationHeight: lottieHeight,
          containerHeight: MediaQuery.sizeOf(context).height,
          containerWidth: MediaQuery.sizeOf(context).width,
          blurBackground: true,
        ),
      ],
    );
  }
}
