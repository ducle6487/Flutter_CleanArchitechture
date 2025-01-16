import 'package:flutter_clean_architechture/app/presentation/first_page/widget/home_weather_content_view.dart';
import 'package:flutter_clean_architechture/core/location/location_permission_observer.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstPageView extends ConsumerStatefulWidget {
  const FirstPageView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FirstPageViewState();
}

class _FirstPageViewState extends ConsumerState<FirstPageView> {
  late final LocationPermissionObserver _permissionObserver;

  @override
  void initState() {
    super.initState();
    _permissionObserver = LocationPermissionObserver();
  }

  @override
  void dispose() {
    super.dispose();
    _permissionObserver.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.appColors.backgroundColor,
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: const FirstPageContentView(),
    );
  }
}
