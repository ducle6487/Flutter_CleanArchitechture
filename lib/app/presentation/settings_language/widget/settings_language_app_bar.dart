import 'package:go_router/go_router.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons.dart';
import 'package:Flutter_CleanArchitechture/core/localization/controller/localization_controller.dart';
import 'package:Flutter_CleanArchitechture/core/localization/provider/localization_provider.dart';
import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_app_bar.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_app_bar_icon_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsLanguageAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const SettingsLanguageAppBar({
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
      title: LocalizationService.translateText(TextType.languageSettings),
      leading: AdvancedAppBarIconModel(
        icon: Icon(AppIcons.back.icon),
        tooltip: LocalizationService.translateText(TextType.languageSettings),
        onTap: () async => await _onTap(context: context),
      ),
      actionList: const [],
    );
  }

  /// Represents app bar the leading button tap event.
  Future<void> _onTap({required BuildContext context}) async {
    context.pop();
  }
}
