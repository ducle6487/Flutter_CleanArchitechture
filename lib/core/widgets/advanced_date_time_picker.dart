import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_clean_architechture/config/app_svg_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';
import '../../config/app_radius.dart';
import 'advanced_shimmer.dart';

class AdvancedDateTimePicker extends ConsumerWidget {
  final String? hintText;
  final Widget? hint;
  final DateTime? value;
  final String? formatString;
  final AdvancedBorderModel border;
  final IconData? suffixIcon;
  final Future<void> Function(DateTime?) onChanged;
  final bool? isLoading;

  const AdvancedDateTimePicker({
    super.key,
    required this.onChanged,
    this.hintText,
    required this.value,
    this.hint,
    this.border = const AdvancedBorderModel(color: Colors.grey),
    this.formatString,
    this.suffixIcon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DateFormat formatter = DateFormat(formatString);

    Widget shimmer = Padding(
      padding: const EdgeInsets.all(AppSpacings.comfortable),
      child: AdvancedShimmer(
        height: AppDimensions.shimmerLineHeight * 2,
        radius: AppRadius.large,
      ),
    );

    return (isLoading != null && isLoading!)
        ? shimmer
        : _buildDatePicker(context, formatter);
  }

  InkWell _buildDatePicker(
    BuildContext context,
    DateFormat formatter,
  ) {
    return InkWell(
      onTap: () {
        HapticFeedback.selectionClick();
        _selectDate(context);
      },
      child: Container(
        color: context.appColors.backgroundColor,
        alignment: Alignment.centerLeft,
        child: InputDecorator(
          decoration: _createDropdownBorder(context: context),
          child: Padding(
            padding: const EdgeInsets.only(
                left: AppSpacings.comfortable,
                right: AppSpacings.compact,
                top: AppSpacings.comfortable,
                bottom: AppSpacings.comfortable),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (hint != null && value != null) hint!,
                Text(
                  (value == null ? hintText : formatter.format(value!)) ?? "",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: value == null
                            ? context.appColors.borderColor
                            : context.appColors.textColor,
                      ),
                ),
                _createCalendarIcon(context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Creates the dropdown border.
  InputDecoration _createDropdownBorder({required BuildContext context}) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      enabledBorder: _getInputBorder(context: context),
      focusedBorder: _getInputBorder(context: context),
      errorBorder: _getInputBorder(context: context),
      disabledBorder: _getInputBorder(context: context),
      focusedErrorBorder: _getInputBorder(context: context),
      border: _getInputBorder(context: context),
    );
  }

  /// Get input border.
  OutlineInputBorder? _getInputBorder({required BuildContext context}) {
    return OutlineInputBorder(
      borderRadius: border.getBorderRadius(context: context),
      borderSide: border.getRoundedRectangleBorder(context: context).side,
    );
  }

  /// Creates the dropdown icon widget.
  Widget _createCalendarIcon({
    required BuildContext context,
  }) {
    return SizedBox(
      height: AppDimensions.smallSuffixIconSize,
      width: AppDimensions.smallSuffixIconSize,
      child: SvgPicture.asset(
        AppSvgIcons.calendar.svg,
        height: AppDimensions.iconSize,
        width: AppDimensions.iconSize,
        colorFilter: ColorFilter.mode(
          context.appColors.textColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: value ?? DateTime.now(),
      firstDate: DateTime(0),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      onChanged(picked);
    }
  }
}
