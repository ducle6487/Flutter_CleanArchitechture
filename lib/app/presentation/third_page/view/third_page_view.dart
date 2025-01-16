import 'package:flutter_clean_architechture/app/presentation/third_page/widget/third_page_content_view.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdPageView extends ConsumerWidget {
  const ThirdPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      color: context.appColors.backgroundColor,
      child: const ThirdPageContentView(),
    );
  }
}
