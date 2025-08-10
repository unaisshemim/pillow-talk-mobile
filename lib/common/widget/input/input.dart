import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillowtalk/utils/constant/sizes.dart';
import 'package:pillowtalk/utils/helpers/responsive_size.dart';
import 'package:pillowtalk/utils/theme/theme_extension.dart';

enum InputVariant { outlined, filled, underlined }

enum InputSize { small, medium, large }

class PInput extends StatefulWidget {
  final String? label;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final bool autofocus;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? prefixText;
  final String? suffixText;
  final InputVariant variant;
  final InputSize size;
  final double? borderRadius;
  final TextCapitalization textCapitalization;
  final String? counterText;
  final bool showCounter;

  const PInput({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.variant = InputVariant.outlined,
    this.size = InputSize.medium,
    this.borderRadius,
    this.textCapitalization = TextCapitalization.none,
    this.counterText,
    this.showCounter = false,
  });

  // Convenient constructors for common use cases
  const PInput.outlined({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.size = InputSize.medium,
    this.borderRadius,
    this.textCapitalization = TextCapitalization.none,
    this.counterText,
    this.showCounter = false,
  }) : variant = InputVariant.outlined;

  const PInput.filled({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.size = InputSize.medium,
    this.borderRadius,
    this.textCapitalization = TextCapitalization.none,
    this.counterText,
    this.showCounter = false,
  }) : variant = InputVariant.filled;

  const PInput.underlined({
    super.key,
    this.label,
    this.hintText,
    this.helperText,
    this.errorText,
    this.controller,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixText,
    this.suffixText,
    this.size = InputSize.medium,
    this.textCapitalization = TextCapitalization.none,
    this.counterText,
    this.showCounter = false,
  }) : variant = InputVariant.underlined,
       borderRadius = null;

  @override
  State<PInput> createState() => _PInputState();
}

class _PInputState extends State<PInput> {
  late bool _obscureText;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    } else {
      _focusNode.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: _getLabelStyle(context)),
          SizedBox(height: _getLabelSpacing()),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          obscureText: _obscureText,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          autofocus: widget.autofocus,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textCapitalization: widget.textCapitalization,
          style: _getTextStyle(context),
          decoration: _getInputDecoration(context),
          buildCounter: widget.showCounter
              ? null
              : (
                  context, {
                  required currentLength,
                  maxLength,
                  required isFocused,
                }) => null,
        ),
        if (widget.helperText != null || widget.errorText != null) ...[
          SizedBox(height: _getHelperSpacing()),
          Text(
            widget.errorText ?? widget.helperText!,
            style: _getHelperStyle(context),
          ),
        ],
      ],
    );
  }

  InputDecoration _getInputDecoration(BuildContext context) {
    final baseDecoration = InputDecoration(
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon,
      suffixIcon: _getSuffixIcon(context),
      prefixText: widget.prefixText,
      suffixText: widget.suffixText,
      counterText: widget.showCounter ? widget.counterText : '',
      contentPadding: _getContentPadding(),
      hintStyle: _getHintStyle(context),
      prefixStyle: _getPrefixSuffixStyle(context),
      suffixStyle: _getPrefixSuffixStyle(context),
      counterStyle: _getCounterStyle(context),
      errorText: widget.errorText,
      errorStyle: _getErrorStyle(context),
      errorMaxLines: 2,
    );

    switch (widget.variant) {
      case InputVariant.outlined:
        return baseDecoration.copyWith(
          border: _getOutlinedBorder(context, false, false),
          enabledBorder: _getOutlinedBorder(context, false, false),
          focusedBorder: _getOutlinedBorder(context, true, false),
          errorBorder: _getOutlinedBorder(context, false, true),
          focusedErrorBorder: _getOutlinedBorder(context, true, true),
          disabledBorder: _getOutlinedBorder(context, false, false, true),
          filled: false,
        );

      case InputVariant.filled:
        return baseDecoration.copyWith(
          border: _getFilledBorder(context, false, false),
          enabledBorder: _getFilledBorder(context, false, false),
          focusedBorder: _getFilledBorder(context, true, false),
          errorBorder: _getFilledBorder(context, false, true),
          focusedErrorBorder: _getFilledBorder(context, true, true),
          disabledBorder: _getFilledBorder(context, false, false, true),
          filled: true,
          fillColor: _getFillColor(context),
        );

      case InputVariant.underlined:
        return baseDecoration.copyWith(
          border: _getUnderlineBorder(context, false, false),
          enabledBorder: _getUnderlineBorder(context, false, false),
          focusedBorder: _getUnderlineBorder(context, true, false),
          errorBorder: _getUnderlineBorder(context, false, true),
          focusedErrorBorder: _getUnderlineBorder(context, true, true),
          disabledBorder: _getUnderlineBorder(context, false, false, true),
          filled: false,
        );
    }
  }

  Widget? _getSuffixIcon(BuildContext context) {
    if (widget.obscureText) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          size: _getIconSize(),
          color: _getIconColor(context),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }
    return widget.suffixIcon;
  }

  // Border methods
  OutlineInputBorder _getOutlinedBorder(
    BuildContext context,
    bool isFocused,
    bool isError, [
    bool isDisabled = false,
  ]) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? PSizes.s12),
      borderSide: BorderSide(
        color: _getBorderColor(context, isFocused, isError, isDisabled),
        width: isFocused ? 2.0 : 1.0,
      ),
    );
  }

  UnderlineInputBorder _getFilledBorder(
    BuildContext context,
    bool isFocused,
    bool isError, [
    bool isDisabled = false,
  ]) {
    return UnderlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? PSizes.s12),
      borderSide: BorderSide(
        color: _getBorderColor(context, isFocused, isError, isDisabled),
        width: isFocused ? 2.0 : 0.0,
      ),
    );
  }

  UnderlineInputBorder _getUnderlineBorder(
    BuildContext context,
    bool isFocused,
    bool isError, [
    bool isDisabled = false,
  ]) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: _getBorderColor(context, isFocused, isError, isDisabled),
        width: isFocused ? 2.0 : 1.0,
      ),
    );
  }

  // Color methods
  Color _getBorderColor(
    BuildContext context,
    bool isFocused,
    bool isError,
    bool isDisabled,
  ) {
    if (isDisabled) return context.pColor.neutral.n40;
    if (isError)
      return context.pColor.primary.base; // Using primary as error color
    if (isFocused) return context.pColor.primary.base;
    return context.pColor.neutral.n60;
  }

  Color _getFillColor(BuildContext context) {
    if (!widget.enabled) return context.pColor.neutral.n20;
    return context.pColor.neutral.n30.withOpacity(0.1);
  }

  Color _getIconColor(BuildContext context) {
    if (!widget.enabled) return context.pColor.neutral.n50;
    if (_isFocused) return context.pColor.primary.base;
    return context.pColor.neutral.n70;
  }

  // Style methods
  TextStyle _getLabelStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getLabelFontSize()),
      fontWeight: FontWeight.w500,
      color: widget.errorText != null
          ? context.pColor.primary.base
          : context.pColor.neutral.n80,
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getTextFontSize()),
      fontWeight: FontWeight.w400,
      color: widget.enabled
          ? context.pColor.neutral.n90
          : context.pColor.neutral.n60,
    );
  }

  TextStyle _getHintStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getTextFontSize()),
      fontWeight: FontWeight.w400,
      color: context.pColor.neutral.n60,
    );
  }

  TextStyle _getHelperStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getHelperFontSize()),
      fontWeight: FontWeight.w400,
      color: widget.errorText != null
          ? context.pColor.primary.base
          : context.pColor.neutral.n70,
    );
  }

  TextStyle _getPrefixSuffixStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getTextFontSize()),
      fontWeight: FontWeight.w400,
      color: context.pColor.neutral.n70,
    );
  }

  TextStyle _getErrorStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getHelperFontSize()),
      fontWeight: FontWeight.w400,
      color: context.pColor.primary.base,
    );
  }

  TextStyle _getCounterStyle(BuildContext context) {
    return TextStyle(
      fontSize: responsive(context, _getHelperFontSize()),
      fontWeight: FontWeight.w400,
      color: context.pColor.neutral.n60,
    );
  }

  // Size methods
  double _getLabelFontSize() {
    switch (widget.size) {
      case InputSize.small:
        return PSizes.s12;
      case InputSize.medium:
        return PSizes.s14;
      case InputSize.large:
        return PSizes.s16;
    }
  }

  double _getTextFontSize() {
    switch (widget.size) {
      case InputSize.small:
        return PSizes.s14;
      case InputSize.medium:
        return PSizes.s16;
      case InputSize.large:
        return PSizes.s18;
    }
  }

  double _getHelperFontSize() {
    switch (widget.size) {
      case InputSize.small:
        return PSizes.s10;
      case InputSize.medium:
        return PSizes.s12;
      case InputSize.large:
        return PSizes.s14;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case InputSize.small:
        return PSizes.s18;
      case InputSize.medium:
        return PSizes.s20;
      case InputSize.large:
        return PSizes.s24;
    }
  }

  EdgeInsets _getContentPadding() {
    switch (widget.size) {
      case InputSize.small:
        return const EdgeInsets.symmetric(
          horizontal: PSizes.s12,
          vertical: PSizes.s8,
        );
      case InputSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: PSizes.s16,
          vertical: PSizes.s12,
        );
      case InputSize.large:
        return const EdgeInsets.symmetric(
          horizontal: PSizes.s20,
          vertical: PSizes.s16,
        );
    }
  }

  double _getLabelSpacing() {
    switch (widget.size) {
      case InputSize.small:
        return PSizes.s4;
      case InputSize.medium:
        return PSizes.s8;
      case InputSize.large:
        return PSizes.s8;
    }
  }

  double _getHelperSpacing() {
    switch (widget.size) {
      case InputSize.small:
        return PSizes.s4;
      case InputSize.medium:
        return PSizes.s4;
      case InputSize.large:
        return PSizes.s8;
    }
  }
}
