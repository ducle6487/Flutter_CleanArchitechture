import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/change_password/provider/change_password_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/change_password/widget/change_password_app_bar.dart';
import 'package:flutter_clean_architechture/app/presentation/change_password/widget/change_password_form_view.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/dialog/dialog_service.dart';

class ChangePasswordView extends ConsumerWidget {
  const ChangePasswordView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      ChangePasswordViewProvider.changePasswordViewControllerProvider,
      (previous, next) {
        if (next.isSuccess) {
          DialogService().changePasswordSuccessDialog();
        }
      },
    );

    return Scaffold(
      appBar: const ChangePasswordAppBar(),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: context.appColors.backgroundColor,
        child: const ChangePasswordFormView(),
      ),
    );
  }
}
