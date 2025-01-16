import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/forgot_password/view/forgot_password_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_in/view/sign_in_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/sign_up/view/sign_up_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/verify/view/verify_view.dart';
import 'package:Flutter_CleanArchitechture/app/presentation/welcome/view/welcome_view.dart';
import 'package:Flutter_CleanArchitechture/core/router/enum/router_type.dart';

GoRoute unAuthenticateddRoutes() => GoRoute(
      name: RouterType.welcome.name,
      path: RouterType.welcome.path,
      builder: (BuildContext context, GoRouterState state) =>
          const WelcomeView(),
      routes: [
        GoRoute(
          path: RouterType.signIn.path,
          name: RouterType.signIn.name,
          builder: (BuildContext context, GoRouterState state) =>
              const SignInView(),
          routes: [
            GoRoute(
              path: RouterType.signUp.path,
              name: RouterType.signUp.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const SignUpView(),
            ),
            GoRoute(
              path: RouterType.verify.path,
              name: RouterType.verify.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const VerifyView(),
            ),
            GoRoute(
              path: RouterType.forgotPassword.path,
              name: RouterType.forgotPassword.name,
              builder: (BuildContext context, GoRouterState state) =>
                  const ForgotPasswordView(),
            ),
          ],
        ),
      ],
    );
