import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';

import 'extension.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField({
    Key? key,
    this.controller,
    this.hintText = '',
    this.validation,
    this.prefixPadding,
    this.onChange,
    this.inputFormatters,
    this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixIconSize,
    this.height,
    this.hintTextSize,
    this.obscureText = false,
    this.readOnly,
    this.fillColor = whiteColor,
    this.isPasswordField,
    this.action,
    this.textCapitalization = TextCapitalization.none,
    this.maxLine = 1,
    this.borderRadius = 100,
  }) : super(key: key);
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final TextInputAction? action;
  final String hintText;
  final bool? isPasswordField;
  final bool obscureText;
  final num? hintTextSize;
  final double? height;
  final String? Function(String? value)? validation;
  final void Function(String value)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final dynamic suffixIcon;
  final SvgGenImage? prefixIcon;
  final double? prefixIconSize;
  final double? prefixPadding;
  final Color fillColor;
  final int maxLine;
  final double borderRadius;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  FocusNode _focus = FocusNode();
  final textFieldFocusNode = FocusNode();
  bool isFocused = false;
  bool obscureValue = false;
  // final Color fillColor = whiteColor;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    obscureValue = widget.obscureText;
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      isFocused = _focus.hasFocus;
    });
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.maxLine == 1
          ? widget.height ?? (!isTablet ? 55.h : 60.h)
          : null,
      child: TextFormField(
        focusNode: _focus,
        readOnly: widget.readOnly ?? false,
        onChanged: widget.onChange,
        validator: widget.validation,
        controller: widget.controller ?? TextEditingController(),
        maxLines: widget.maxLine,
        textCapitalization: widget.textCapitalization,
        autofocus: false,
        style: hintTextStyle(
            size: 16.sp, color: hintTextColor, weight: FontWeight.w400),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText,
        textInputAction: widget.action ?? TextInputAction.done,
        keyboardType: widget.keyboardType,
        cursorColor: primaryBrown,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabled: true,
          // contentPadding: EdgeInsets.zero,
          hintStyle: hintTextStyle(
              size: widget.hintTextSize ?? (!isTablet ? 16.sp : 20.sp),
              weight: FontWeight.w500,
              color: hintColor),
          prefixIcon: widget.prefixIcon != null
              ? (widget.prefixIcon!
                      .svg(
                          height: widget.prefixIconSize ??
                              (!isTablet ? 20.h : 25.h),
                          width: widget.prefixIconSize ??
                              (!isTablet ? 20.h : 25.h),
                          colorFilter: ColorFilter.mode(
                              _focus.hasFocus ? primaryBrown : hintColor,
                              BlendMode.srcIn),
                          fit: BoxFit.contain)
                      .paddingAll(widget.prefixPadding ?? 12.w))
                  .paddingOnly(left: 5.w)
              : null,
          suffixIcon: widget.suffixIcon ?? const SizedBox(),
          // : const SizedBox(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: disableTextFiledColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryBrown,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whiteColor,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          filled: true,
          fillColor: widget.fillColor,
        ),
      ),
    );
  }
}

class AppTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final double prefixIconHeight;
  final double suffixIconHeight;
  final double prefixIconWidth;
  final double suffixIconWidth;
  final TextStyle? hintTextStyle;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final bool showPrefixIcon;
  final Widget? showPrefixWidget;
  final String suffixIcon;
  final bool showSuffixIcon;

  final TextEditingController? textEditingController;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;

  final EdgeInsets? textFieldPadding;
  final double? labelTextSize;
  final bool obscureText;
  final double? radius;
  final bool isError;

  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final Function(String value)? onChanged;
  final Function(String value) validator;
  final bool? readOnly;
  final bool showCursor;

  AppTextField(
      {Key? key,
      this.labelText = '',
      this.textEditingController,
      this.prefixIcon,
      this.suffixIcon = '',
      this.readOnly,
      this.showCursor = true,
      this.hintTextStyle,
      this.onTap,
      this.textStyle,
      this.showPrefixWidget,
      this.maxLines = 1,
      this.radius,
      this.maxLength,
      required this.validator,
      this.onChanged,
      this.textFieldPadding,
      this.labelTextSize,
      this.keyboardType,
      this.isError = false,
      this.obscureText = false,
      this.showPrefixIcon = true,
      this.inputFormatter,
      this.showSuffixIcon = false,
      this.prefixIconHeight = 16,
      this.suffixIconHeight = 24,
      this.prefixIconWidth = 20,
      this.suffixIconWidth = 24,
      this.hintText = ''})
      : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  FocusNode focusNode = FocusNode();
  final textFieldFocusNode = FocusNode();
  bool isFocused = false;
  bool obscureValue = false;

  void _onFocusChange() {
    setState(() {
      isFocused = focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    obscureValue = widget.obscureText;
    super.initState();
  }

  String textFieldValue = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          widget.textFieldPadding ?? const EdgeInsets.only(left: 15, right: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.labelText.isNotEmpty)
            Align(
              alignment: Alignment.centerLeft,
              child: widget.labelText.appCommonText(
                  weight: FontWeight.w400,
                  size: widget.labelTextSize ?? (!isTablet ? 14 : 17),
                  color: Colors.black),
            ).paddingOnly(left: 3),
          (8).space(),
          TextFormField(
            smartQuotesType: SmartQuotesType.disabled,
            smartDashesType: SmartDashesType.disabled,
            enableSuggestions: false,
            onTap: widget.onTap,
            readOnly: widget.readOnly ?? false,
            showCursor: widget.showCursor,
            enableIMEPersonalizedLearning: false,
            autocorrect: false,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            maxLines: widget.maxLines,
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            inputFormatters: widget.inputFormatter,
            focusNode: focusNode,
            validator: (value) {
              return widget.validator(value!);
            },
            onChanged: (value) {
              textFieldValue = value;
              widget.onChanged!.call(value);
            },
            cursorColor: primaryBrown,
            style: widget.textStyle ??
                TextStyle(
                  fontSize: !isTablet ? 15 : 18,
                  color: blackColor,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'maax-medium-medium',
                ),
            obscureText: obscureValue,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  vertical: !isTablet ? 15 : 20, horizontal: 20),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.showSuffixIcon
                  ? Container(
                      child: GestureDetector(
                          onTap: _toggleObscured,
                          child: obscureValue
                              ? Assets.icons.openEye
                                  .svg(
                                      colorFilter: ColorFilter.mode(
                                          primaryBrown, BlendMode.srcIn))
                                  .paddingAll(4)
                              : Assets.icons.closeEye
                                  .svg(
                                      colorFilter: ColorFilter.mode(
                                          primaryBrown, BlendMode.srcIn))
                                  .paddingAll(4)),
                    ).paddingOnly(right: 20)
                  : widget.showPrefixWidget,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle ??
                  GoogleFonts.montserrat(
                      fontSize: !isTablet ? 14 : 18,
                      fontWeight: FontWeight.w400,
                      color: hintStepColor),
              /* fillColor: textFieldValue.isNotEmpty
                  ? Colors.transparent
                  : widget.isError
                      ? appBlackColor.withOpacity(0.5)
                      : (_focusNode.hasFocus)
                          ? Colors.transparent
                          : hintTextColor.withOpacity(0.2),*/
              fillColor: Colors.white,
              filled: true,
              errorStyle: TextStyle(height: 0, fontSize: !isTablet ? 12 : 15),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 30),
                  borderSide: BorderSide(
                      color:
                          textFieldValue.isNotEmpty ? primaryBrown : skyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 30),
                  borderSide: const BorderSide(color: primaryBrown)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 30),
                  borderSide: BorderSide(
                      color: widget.isError
                          ? Colors.red
                          : hintTextColor.withOpacity(0.2))),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      widget.radius ?? (!isTablet ? 30 : 40)),
                  borderSide: BorderSide(
                      color: widget.isError ? primaryBrown : primaryBrown)),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      obscureValue = !obscureValue;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }
}
