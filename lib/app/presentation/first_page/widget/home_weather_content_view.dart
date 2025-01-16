import 'package:Flutter_CleanArchitechture/core/localization/enum/text_type.dart';
import 'package:Flutter_CleanArchitechture/core/localization/service/localization_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirstPageContentView extends ConsumerStatefulWidget {
  const FirstPageContentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FirstPageContentViewState();
}

class _FirstPageContentViewState extends ConsumerState<FirstPageContentView> {
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        LocalizationService.translateText(TextType.firstPage),
      ),
    );
  }
}
