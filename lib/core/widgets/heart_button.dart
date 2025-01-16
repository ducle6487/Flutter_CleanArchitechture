import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons_image.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/gesture_detector.dart';

class HeartButton extends StatefulWidget {
  final bool isFollowed;
  final double? size;
  final Function()? onTap;

  const HeartButton({
    super.key,
    required this.isFollowed,
    this.size,
    this.onTap,
  });

  @override
  HeartButtonState createState() => HeartButtonState();
}

class HeartButtonState extends State<HeartButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(
        milliseconds: 150,
      ), // Reduced duration for faster animation
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 1.25).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceInOut,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    }
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetectorWithVibration(
      onTap: _onTap,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: Image(
              image: widget.isFollowed
                  ? AppIconsImage.heartSelected.asset
                  : AppIconsImage.heart.asset,
              height: widget.size ?? AppDimensions.iconSize,
              color: context.appColors.primaryColor,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
