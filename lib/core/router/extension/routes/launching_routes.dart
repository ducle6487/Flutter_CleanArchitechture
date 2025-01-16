import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/app/presentation/launch/view/lauch_view.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';

GoRoute launchingRoutes() => GoRoute(
      name: RouterType.launch.name,
      path: RouterType.launch.path,
      builder: (BuildContext context, GoRouterState state) =>
          const LaunchView(),
    );
