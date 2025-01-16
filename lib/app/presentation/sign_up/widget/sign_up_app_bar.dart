import 'package:Flutter_CleanArchitechture/app/presentation/sign_up/provider/sign_up_view_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/router/extension/router_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_app_bar.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const SignUpAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedAppBar(
      title: "",
      isTransparent: true,
      leading: AdvancedAppBarIconModel(
        icon: Icon(AppIcons.back.icon),
        tooltip: LocalizationService.translateText(TextType.menu),
        onTap: () async => await _onTap(context: context, ref: ref),
      ),
      actionList: const [],
    );
  }

  /// Represents app bar the leading button tap event.
  Future<void> _onTap({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    ref
        .watch(SignUpViewProvider.signUpViewControllerProvider.notifier)
        .resetState();
    context.closePage();
  }
}
