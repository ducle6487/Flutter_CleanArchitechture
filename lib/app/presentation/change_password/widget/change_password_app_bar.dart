import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/change_password/provider/change_password_view_provider.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_app_bar.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_app_bar_icon_model.dart';

class ChangePasswordAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const ChangePasswordAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return content(context, ref);
  }

  Widget content(
    BuildContext context,
    WidgetRef ref,
  ) {
    return AdvancedAppBar(
      title: LocalizationService.translateText(TextType.changePassword),
      leading: AdvancedAppBarIconModel(
        icon: Icon(AppIcons.back.icon),
        tooltip: LocalizationService.translateText(TextType.changePassword),
        onTap: () async => await _onTap(
          context: context,
          ref: ref,
        ),
      ),
      actionList: const [],
    );
  }

  Future<void> _onTap({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    ref
        .watch(ChangePasswordViewProvider
            .changePasswordViewControllerProvider.notifier)
        .resetState();
    context.pop();
  }
}
