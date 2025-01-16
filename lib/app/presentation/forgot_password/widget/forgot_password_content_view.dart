import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:Flutter_CleanArchitechture/core/router/enum/router_type.dart';
import 'forgot_password_method_view.dart';

class ForgotPasswordContentView extends ConsumerWidget {
  const ForgotPasswordContentView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ForgotPasswordMethodView(),
      ],
    );
  }

  void goToForgetPasswordScreen(BuildContext context) {
    context.goNamed(RouterType.forgotPassword.name);
  }
}
