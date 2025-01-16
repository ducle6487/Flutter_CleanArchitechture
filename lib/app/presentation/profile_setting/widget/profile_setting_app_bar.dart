import 'package:flutter_clean_architechture/app/presentation/profile_setting/provider/profile_setting_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/core/localization/controller/localization_controller.dart';
import 'package:flutter_clean_architechture/core/localization/provider/localization_provider.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/router/extension/router_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_app_bar.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSettingAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const ProfileSettingAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocalizationState state =
        ref.watch(LocalizationProvider.localizationControllerProvider);

    return state.toggleReload ? content(context, ref) : content(context, ref);
  }

  Widget content(
    BuildContext context,
    WidgetRef ref,
  ) {
    return AdvancedAppBar(
      title: LocalizationService.translateText(TextType.profile),
      leading: AdvancedAppBarIconModel(
        icon: Icon(AppIcons.back.icon),
        tooltip: LocalizationService.translateText(TextType.profile),
        onTap: () async => await _onTap(
          context: context,
          ref: ref,
        ),
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
        .watch(ProfileSettingViewProvider.profileSettingViewProvider.notifier)
        .resetState();
    context.closePage();
  }
}
