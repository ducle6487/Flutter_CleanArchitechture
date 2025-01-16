import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_in/provider/sign_in_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/sign_up/provider/sign_up_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/welcome/enum/welcome_view_type.dart';
import 'package:flutter_clean_architechture/app/presentation/welcome/widget/continue_section.dart';
import 'package:flutter_clean_architechture/app/presentation/welcome/widget/start_section.dart';
import 'package:flutter_clean_architechture/config/app_images.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

class WelcomeContentView extends ConsumerStatefulWidget {
  const WelcomeContentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _WelcomeContentViewState();
}

class _WelcomeContentViewState extends ConsumerState<WelcomeContentView> {
  WelcomeViewType viewType = WelcomeViewType.startType;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    Future<void> onStartedTap() async {
      setState(() {
        viewType = WelcomeViewType.continueType;
      });
    }

    Future<void> onTapYes(WidgetRef ref) async {
      ref
          .watch(SignInViewProvider.signInViewControllerProvider.notifier)
          .resetState();
      ref
          .watch(SignUpViewProvider.signUpViewControllerProvider.notifier)
          .resetState();
      context.goNamed(RouterType.signIn.name);
      setState(() {
        viewType = WelcomeViewType.startType;
      });
    }

    Future<void> onTapNo() async {
      setState(() {
        viewType = WelcomeViewType.startType;
      });
    }

    Widget backgroundImage = Image(
      image: AppImages.welcomeBackground.asset,
      width: width,
      fit: BoxFit.fill,
    );

    Widget maskView = Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            (context.appColors.backgroundColor).withOpacity(0.7),
            (context.appColors.backgroundColor).withOpacity(0.25),
            (context.appColors.backgroundColor).withOpacity(0.3),
            (context.appColors.backgroundColor).withOpacity(0.6),
            (context.appColors.backgroundColor).withOpacity(0.7),
            (context.appColors.backgroundColor).withOpacity(1),
            (context.appColors.backgroundColor),
            (context.appColors.backgroundColor)
          ],
          tileMode: TileMode.clamp,
        ),
      ),
    );

    Widget contentView = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: width,
          height: height / 2,
          child: Stack(
            children: [
              Image(
                height: height / 2,
                image: AppImages.welcomeMask.asset,
                fit: BoxFit.fitHeight,
              ),
              if (viewType == WelcomeViewType.startType)
                AnimatedSwitcher(
                  duration: Durations.medium1,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child: StartSection(
                    onTap: () => onStartedTap(),
                  ),
                )
              else
                AnimatedSwitcher(
                  duration: Durations.medium1,
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child: ContinueSection(
                    onTapYes: () => onTapYes(ref),
                    onTapNo: () => onTapNo(),
                  ),
                )
            ],
          ),
        ),
      ],
    );

    return Container(
      color: context.appColors.backgroundColor,
      child: Stack(
        children: [
          backgroundImage,
          maskView,
          contentView,
        ],
      ),
    );
  }
}
