import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThirdPageContentView extends ConsumerStatefulWidget {
  const ThirdPageContentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ThirdPageContentViewState();
}

class _ThirdPageContentViewState extends ConsumerState<ThirdPageContentView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocalizationService.translateText(TextType.thirdPage),
      ),
    );
  }
}
