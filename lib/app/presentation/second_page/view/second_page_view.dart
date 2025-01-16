import 'package:Flutter_CleanArchitechture/app/presentation/second_page/widget/second_page_content_view.dart';
import 'package:Flutter_CleanArchitechture/core/location/location_permission_observer.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondPageView extends ConsumerStatefulWidget {
  const SecondPageView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SecondViewState();
}

class _SecondViewState extends ConsumerState<SecondPageView> {
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
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: context.appColors.backgroundColor,
      child: const SecondPageContentView(),
    );
  }
}
