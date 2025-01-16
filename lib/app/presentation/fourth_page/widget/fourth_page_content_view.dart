import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FourthPageContentView extends ConsumerStatefulWidget {
  const FourthPageContentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FourthPageContentViewState();
}

class _FourthPageContentViewState extends ConsumerState<FourthPageContentView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocalizationService.translateText(TextType.fourthPage),
      ),
    );
  }
}
