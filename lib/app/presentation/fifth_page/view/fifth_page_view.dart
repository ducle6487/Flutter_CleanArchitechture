import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/fifth_page/widget/fifth_page_content_view.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

class FifthPageView extends ConsumerWidget {
  const FifthPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: context.appColors.backgroundColor,
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      child: const FifthPageContentView(),
    );
  }
}
