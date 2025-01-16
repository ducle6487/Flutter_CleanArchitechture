import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/route_manager.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architechture/config/app_images.dart';
import 'package:flutter_clean_architechture/core/authorization/service/authorization_service.dart';
import 'package:flutter_clean_architechture/core/router/enum/router_type.dart';

class LaunchView extends StatefulWidget {
  const LaunchView({
    super.key,
  });

  @override
  State<LaunchView> createState() => _LaunchViewState();
}

class _LaunchViewState extends State<LaunchView> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        await Future.delayed(Durations.long1, () {
          if (AuthorizationService.instance.isAuthorized) {
            Get.context?.goNamed(RouterType.home.name);
          } else {
            AuthorizationService.instance.clearToken();
          }
        });
      },
    );

    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Image(
        image: AppImages.splashCenterPart.asset,
        fit: BoxFit.contain,
        width: MediaQuery.sizeOf(context).width * 0.6,
      ),
    );
  }
}
