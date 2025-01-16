import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SecondPageContentView extends ConsumerStatefulWidget {
  const SecondPageContentView({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SecondPageContentViewState();
}

class _SecondPageContentViewState extends ConsumerState<SecondPageContentView> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocalizationService.translateText(TextType.secondPage),
      ),
    );
  }
}
