import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FifthPageContentView extends ConsumerStatefulWidget {
  const FifthPageContentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FifthPageContentViewState();
}

class _FifthPageContentViewState extends ConsumerState<FifthPageContentView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocalizationService.translateText(TextType.fifthPage),
      ),
    );
  }
}
