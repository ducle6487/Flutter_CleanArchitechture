import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedRadioButtonView extends ConsumerWidget {
  final List<String> options;
  final String? selectedOption;
  final TextStyle? titleStyle;
  final Function(String) onChanged;

  const AdvancedRadioButtonView({
    required this.options,
    required this.selectedOption,
    required this.onChanged,
    this.titleStyle,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildContentView(context);
  }

  Widget _buildContentView(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: options.map((option) {
        return RadioListTile<String>(
          title: Text(option, style: titleStyle),
          value: option,
          groupValue: selectedOption,
          onChanged: (value) {
            HapticFeedback.selectionClick();
            onChanged(value!);
          },
          contentPadding: EdgeInsets.zero,
        );
      }).toList(),
    );
  }
}
