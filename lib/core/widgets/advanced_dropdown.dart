import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_border_model.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_dropdown_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/app_radius.dart';
import 'advanced_shimmer.dart';

class AdvancedDropdown extends ConsumerWidget {
  final List<AdvancedDropdownItemModel> options;
  final AdvancedDropdownItemModel? selectedItem;
  final Future<void> Function(AdvancedDropdownItemModel?) onChanged;
  final AdvancedBorderModel border;
  final Color? textColor;
  final Color? canvasColor;
  final Widget? hint;
  final bool disableHint;
  final bool? isLoading;

  const AdvancedDropdown({
    super.key,
    required this.options,
    required this.selectedItem,
    required this.onChanged,
    this.textColor,
    this.canvasColor,
    this.border = const AdvancedBorderModel(color: Colors.grey),
    this.disableHint = false,
    this.hint,
    this.isLoading = false,
  });

  /// Creates a copy of this class.
  AdvancedDropdown copyWith({
    List<AdvancedDropdownItemModel>? options,
    AdvancedDropdownItemModel? selectedItem,
    Future<void> Function(AdvancedDropdownItemModel?)? onChanged,
    AdvancedBorderModel? border,
    Color? textColor,
    Color? canvasColor,
    bool? disableHint,
    Widget? hint,
    bool? isLoading,
    Color? borderColor,
  }) {
    return AdvancedDropdown(
      options: options ?? this.options,
      selectedItem: selectedItem ?? this.selectedItem,
      onChanged: onChanged ?? this.onChanged,
      border: border ?? this.border,
      textColor: textColor ?? this.textColor,
      canvasColor: canvasColor ?? this.canvasColor,
      hint: hint ?? this.hint,
      disableHint: disableHint ?? this.disableHint,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget shimmer = Padding(
      padding: const EdgeInsets.all(AppSpacings.comfortable),
      child: AdvancedShimmer(
        height: AppDimensions.shimmerLineHeight * 2,
        radius: AppRadius.large,
      ),
    );

    return (isLoading != null && isLoading!)
        ? shimmer
        : _buildDropDown(context);
  }

  Widget _buildDropDown(BuildContext context) {
    return Container(
      color: context.appColors.backgroundColor,
      // height: AppDimensions.widgetHeight,
      width: MediaQuery.sizeOf(context).width,
      child: InputDecorator(
        decoration: _createDropdownBorder(context: context),
        child: DropdownButtonHideUnderline(
          child: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: canvasColor,
            ),
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<AdvancedDropdownItemModel>(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacings.squishy,
                ),
                borderRadius: border.getBorderRadius(context: context),
                enableFeedback: true,
                value: selectedItem,
                hint: hint,
                disabledHint: hint,
                isExpanded: true,
                onChanged: (model) async {
                  HapticFeedback.selectionClick();
                  onChanged(model);
                },
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: context.appColors.textColor),
                icon: _createDropdownIcon(context: context),
                items: _createDropdownItemList(context: context),
              ),
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
  Widget? _createDropdownIcon({
    required BuildContext context,
  }) {
    return Container(
      height: AppDimensions.suffixIconSize,
      width: AppDimensions.suffixIconSize,
      padding: const EdgeInsets.only(right: 10),
      child: Icon(
        size: AppDimensions.suffixIconSize,
        AppIcons.arrowDropDown.icon,
        color: context.appColors.textColor,
      ),
    );
  }

  /// Creates the dropdown item list.
  List<DropdownMenuItem<AdvancedDropdownItemModel>>? _createDropdownItemList({
    required BuildContext context,
  }) {
    return options.map<DropdownMenuItem<AdvancedDropdownItemModel>>((item) {
      return DropdownMenuItem<AdvancedDropdownItemModel>(
        value: item,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Row(
            children: <Widget>[
              if (item.icon != null)
                Row(
                  children: [
                    Icon(
                      item.icon,
                      color: context.appColors.textColor,
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  item.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: textColor ?? context.appColors.textColor,
                      ),
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
      );
    }).toList();
  }
}
