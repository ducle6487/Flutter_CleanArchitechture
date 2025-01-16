import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/widget/profile_setting_app_bar.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/profile_setting/widget/profile_setting_content_view.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';

class ProfileSettingView extends ConsumerWidget {
  const ProfileSettingView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const ProfileSettingAppBar(),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: context.appColors.dimBackgroundColor,
        child: const ProfileSettingContentView(),
      ),
    );
  }
}
