import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/widget/notification_history_appbar.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/widget/notification_history_content_view.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';

class NotificationHistoryView extends ConsumerStatefulWidget {
  const NotificationHistoryView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationHistoryViewState();
}

class _NotificationHistoryViewState
    extends ConsumerState<NotificationHistoryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NotificationHistoryAppbar(),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        color: context.appColors.appBarColor,
        child: const NotificationHistoryContentView(),
      ),
    );
  }
}
