import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedRefreshIndicator extends ConsumerStatefulWidget {
  final Future<void> Function() onRefresh;
  final Widget content;
  final ScrollController? scrollController;
  final ScrollPhysics? physics;

  const AdvancedRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.content,
    this.scrollController,
    this.physics,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdvancedRefreshIndicatorState();
}

class _AdvancedRefreshIndicatorState
    extends ConsumerState<AdvancedRefreshIndicator> {
  @override
  void initState() {
    super.initState();
    widget.scrollController?.addListener(
      () {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        FocusManager.instance.primaryFocus?.unfocus;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        HapticFeedback.selectionClick();
        widget.onRefresh();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: widget.scrollController,
                  physics:
                      widget.physics ?? const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: widget.content,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
