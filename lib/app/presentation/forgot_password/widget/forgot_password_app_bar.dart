import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_app_bar.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_app_bar_icon_model.dart';

class ForgotPasswordAppBar extends ConsumerWidget
    implements PreferredSizeWidget {
  const ForgotPasswordAppBar({
    this.onTap,
    super.key,
    required,
  });
  final Future<void> Function()? onTap;
  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AdvancedAppBar(
      title: AppStrings.emptyText.text,
      isTransparent: true,
      leading: AdvancedAppBarIconModel(
        icon: Icon(AppIcons.back.icon),
        tooltip:
            LocalizationService.translateText(TextType.forgotPasswordTitle),
        onTap: onTap,
      ),
      actionList: const [],
    );
  }

  /// Represents app bar the leading button tap event.
}
