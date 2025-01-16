import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:Flutter_CleanArchitechture/config/app_dimensions.dart';
import 'package:Flutter_CleanArchitechture/config/app_icons.dart';
import 'package:Flutter_CleanArchitechture/config/app_radius.dart';
import 'package:Flutter_CleanArchitechture/config/app_spacings.dart';
import 'package:Flutter_CleanArchitechture/config/app_strings.dart';
import 'package:Flutter_CleanArchitechture/core/theme/extension/theme_extension.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/advanced_shimmer.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_border_model.dart';
import 'package:Flutter_CleanArchitechture/core/widgets/model/advanced_icon_button_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdvancedTextFieldForm extends ConsumerStatefulWidget {
  final String? title;
  final bool obscureText;
  final IconData? titleIcon;
  final Widget? leadingWidget;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final AdvancedBorderModel border;
  final String? hintText;
  final Widget? hint;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final bool isReadOnly;
  final Future<void> Function(String)? onChanged;
  final void Function()? onTapClearButton;
  final Future<void> Function(String?)? onSaved;
  final Future<void> Function(String)? onFieldSubmitted;
  final Future<void> Function()? onEditingComplete;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final AdvancedIconButtonModel? suffixIconButton;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool? isLoading;
  final String? validator;
  final AutovalidateMode? autoValidateMode;
  final bool? showClearButton;
  final bool? isHideLeadingIconOnTap;
  final Color? iconColor;

  const AdvancedTextFieldForm({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    this.style,
    this.obscureText = false,
    this.title,
    this.titleIcon,
    this.leadingWidget,
    this.textInputAction = TextInputAction.done,
    this.border = const AdvancedBorderModel(color: Colors.grey),
    this.hintText,
    this.minLines,
    this.maxLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.isReadOnly = false,
    this.onChanged,
    this.onSaved,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.sentences,
    this.suffixIconButton,
    this.textAlign = TextAlign.start,
    this.isLoading,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.showClearButton,
    this.onTapClearButton,
    this.isHideLeadingIconOnTap,
    this.iconColor,
    this.hint,
  });

  @override
  createState() => _AdvancedTextFieldFormState();
}

class _AdvancedTextFieldFormState extends ConsumerState<AdvancedTextFieldForm> {
  late bool isHideLeadingIcon = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _createTextField(context: context);
  }

  /// Creates a button.
  Widget _createTextField({required BuildContext context}) {
    Widget textField = TextField(
      obscureText: widget.obscureText,
      style: widget.style,
      textAlign: widget.textAlign,
      textInputAction: widget.textInputAction,
      controller: widget.textEditingController,
      focusNode: widget.focusNode,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.isReadOnly,
      onChanged: (changed) async {
        if (widget.onChanged != null) {
          widget.onChanged!(changed);
        }
      },
      onEditingComplete: () {
        widget.onEditingComplete;
        widget.focusNode.unfocus();
        SystemChannels.textInput.invokeMethod('TextInput.hide');
      },
      onSubmitted: widget.onFieldSubmitted,
      keyboardType: widget.keyboardType,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        enabled: true,
        alignLabelWithHint: true,
        counterStyle: const TextStyle(
          height: double.minPositive,
        ),
        counterText: "",
        label: widget.hint,
        labelText: widget.hintText,
        labelStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: context.appColors.borderColor,
            ),
        hintText: "",
        hintStyle: TextStyle(
          color: context.appColors.textColor,
        ),
        errorStyle: TextStyle(
          color: context.appColors.errorColor,
        ),
        errorText: widget.validator,
        prefixIcon: _createTitleSection(context: context),
        suffixIcon: _createIconButton(
          context: context,
          advancedIconButtonModel: widget.suffixIconButton,
          showClearButton: widget.showClearButton ?? false,
          textEditingController: widget.textEditingController,
          focusNode: widget.focusNode,
        ),
        contentPadding: const EdgeInsets.all(
          AppSpacings.comfortable,
        ),
        floatingLabelAlignment: FloatingLabelAlignment.start,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        filled: true,
        fillColor: widget.isReadOnly
            ? context.appColors.dimBackgroundColor
            : context.appColors.backgroundColor,
        focusedBorder: _getFocusInputBorder(context: context),
        enabledBorder: _getInputBorder(context: context),
        focusedErrorBorder: _getInputBorder(context: context),
        errorBorder: _getInputBorder(context: context),
        disabledBorder: _getInputBorder(context: context),
        border: _getInputBorder(context: context),
      ),
    );

    Widget shimmer = Padding(
      padding: const EdgeInsets.all(AppSpacings.comfortable),
      child: AdvancedShimmer(
        height: AppDimensions.shimmerLineHeight,
        radius: AppRadius.large,
      ),
    );

    return (widget.isLoading != null && widget.isLoading!)
        ? shimmer
        : textField;
  }

  /// Creates the title section.
  Widget? _createTitleSection({required BuildContext context}) {
    return (widget.title != null ||
            (widget.titleIcon != null &&
                (widget.isHideLeadingIconOnTap == null ||
                    (widget.isHideLeadingIconOnTap! && !isHideLeadingIcon))))
        ? FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                if (widget.titleIcon != null)
                  if (widget.isHideLeadingIconOnTap == null ||
                      (widget.isHideLeadingIconOnTap! && !isHideLeadingIcon))
                    Row(
                      children: [
                        Icon(
                          widget.titleIcon,
                          color:
                              widget.iconColor ?? context.appColors.textColor,
                        ),
                      ],
                    ),
                if (widget.leadingWidget != null) widget.leadingWidget!,
                if (widget.title != null)
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        '${widget.title}:',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: context.appColors.textColor),
                      ),
                    ],
                  ),
              ],
            ),
          )
        : null;
  }

  /// Creates a button.
  Widget? _createIconButton({
    required BuildContext context,
    required AdvancedIconButtonModel? advancedIconButtonModel,
    required bool showClearButton,
    required TextEditingController textEditingController,
    required FocusNode focusNode,
  }) {
    if (showClearButton) {
      return GestureDetector(
        onTap: () {
          if (widget.onTapClearButton != null) {
            widget.onTapClearButton!();
          }
          textEditingController.clear();
          focusNode.unfocus;
          SystemChannels.textInput.invokeMethod('TextInput.hide');
        },
        child: Container(
          padding: const EdgeInsets.all(AppSpacings.compact),
          child: Icon(
            AppIcons.close.icon,
            size: AppDimensions.clearButtonSize,
          ),
        ),
      );
    }

    if (advancedIconButtonModel == null) {
      return null;
    }

    return IconButton(
      onPressed: advancedIconButtonModel.onTap,
      icon: _getIcon(advancedIconButtonModel),
      tooltip: advancedIconButtonModel.tooltip,
      style: ButtonStyle(
        foregroundColor: WidgetStatePropertyAll(
          advancedIconButtonModel.onTap == null
              ? context.appColors.transparentColor
              : context.appColors.textColor,
        ),
        shape: WidgetStatePropertyAll(
          widget.border.copyWith(hasBorder: false).getRoundedRectangleBorder(
                context: context,
              ),
        ),
      ),
    );
  }

  Widget _getIcon(
    AdvancedIconButtonModel? advancedIconButtonModel,
  ) {
    if (advancedIconButtonModel?.svgIcon != null) {
      return SvgPicture.asset(
        advancedIconButtonModel?.svgIcon ?? AppStrings.emptyText.text,
        height: advancedIconButtonModel?.size,
        width: advancedIconButtonModel?.size,
        colorFilter: advancedIconButtonModel?.color != null
            ? ColorFilter.mode(advancedIconButtonModel!.color!, BlendMode.srcIn)
            : null,
      );
    }

    return Icon(
      advancedIconButtonModel?.icon,
      color: advancedIconButtonModel?.color,
      size: advancedIconButtonModel?.size,
    );
  }

  /// Get input border.
  InputBorder? _getInputBorder({
    required BuildContext context,
  }) {
    return OutlineInputBorder(
      borderSide: widget.border
          .getRoundedRectangleBorder(
            context: context,
            isSelected: false,
            isDisabled: widget.isReadOnly,
          )
          .side,
    );
  }

  /// Get focus input border
  InputBorder? _getFocusInputBorder({required BuildContext context}) {
    return OutlineInputBorder(
      borderSide: widget.border
          .getRoundedRectangleBorder(
            context: context,
            isSelected: true,
            isDisabled: widget.isReadOnly,
          )
          .side,
    );
  }
}
