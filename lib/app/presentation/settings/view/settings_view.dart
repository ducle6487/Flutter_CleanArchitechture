import 'package:Flutter_CleanArchitechture/app/presentation/settings/widget/settings_app_bar.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/settings/widget/settings_content_view.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const SettingsAppBar(),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: context.appColors.dimBackgroundColor,
        child: const SettingsContentView(),
      ),
    );
  }
}
