import 'package:get/route_manager.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/core/router/extension/routes/authenticated_routes.dart';
import 'package:flutter_clean_architechture/core/router/extension/routes/launching_routes.dart';
import 'package:flutter_clean_architechture/core/router/extension/routes/un_authenticated_routes.dart';

extension RouterExtension on BuildContext {
  /// Static instance of [GoRouter] for application-wide routing.
  static final GoRouter goRouter = GoRouter(
    navigatorKey: Get.key,
    debugLogDiagnostics: true,
    initialLocation: RouterType.launch.path,
    routes: <RouteBase>[
      launchingRoutes(),
      unAuthenticateddRoutes(),
      authenticatedRoutes()
    ],
  );

  /// Opens a new page using the GoRouter.
  void openPage({required RouterType screenType}) =>
      GoRouter.of(this).goNamed(screenType.name);

  /// Closes the current page using the GoRouter.
  void closePage() => GoRouter.of(this).pop();

  /// Retrieves the current location from the router.
  String getCurrentLocation() {
    final RouteMatch lastMatch =
        goRouter.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : goRouter.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
