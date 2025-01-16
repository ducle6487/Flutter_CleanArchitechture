import 'package:Flutter_CleanArchitechture/app/presentation/settings_language/widget/settings_language_app_bar.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings_language/widget/settings_language_content_view.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsLanguageView extends ConsumerWidget {
  const SettingsLanguageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const SettingsLanguageAppBar(),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: context.appColors.backgroundColor,
        child: SettingsLanguageContentView(),
      ),
    );
  }
}
