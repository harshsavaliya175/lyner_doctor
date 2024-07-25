import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';


import 'extension.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField(
      {Key? key,
      this.controller,
      this.hintText = '',
      this.validation,
      this.prefixPadding,
      this.onChange,
      this.inputFormatters,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.height,
      this.hintTextSize,
      this.obscureText,
      this.readOnly,
      this.fillColor = whiteColor,
      this.isPasswordField})
      : super(key: key);
  final TextEditingController? controller;
  final String hintText;
  final bool? isPasswordField;
  final bool? obscureText;
  final num? hintTextSize;
  final double? height;
  final String? Function(String?)? validation;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Widget? suffixIcon;
  final SvgGenImage? prefixIcon;
  final double? prefixPadding;
  Color fillColor;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final int maxLine = 1;
  FocusNode _focus = FocusNode();

  // final Color fillColor = whiteColor;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {});
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 55.w,
      child: TextFormField(
        focusNode: _focus,
        readOnly: widget.readOnly ?? false,
        onChanged: widget.onChange,
        validator: widget.validation,
        controller: widget.controller ?? TextEditingController(),
        maxLines: maxLine,
        autofocus: false,
        style: hintTextStyle(
            size: 16.sp, color: hintTextColor, weight: FontWeight.w400),
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        textInputAction: TextInputAction.done,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          hintText: widget.hintText,
          enabled: true,
          contentPadding: EdgeInsets.zero,
          hintStyle: hintTextStyle(
              size: widget.hintTextSize ?? 16.sp,
              weight: FontWeight.w500,
              color: hintColor),
          prefixIcon: widget.prefixIcon != null
              ? (widget.prefixIcon!
                      .svg(
                          height: 20.w,
                          width: 20.w,
                          colorFilter: ColorFilter.mode(
                              _focus.hasFocus ? primaryBrown : hintColor,
                              BlendMode.srcIn),
                          fit: BoxFit.contain)
                      .paddingAll(widget.prefixPadding ?? 12.w))
                  .paddingOnly(left: 5.w)
              : SizedBox(),
          suffixIcon: widget.isPasswordField ?? false
              ? widget.suffixIcon ?? const SizedBox()
              : const SizedBox(),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: disableTextFiledColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: primaryBrown,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(100),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: whiteColor,
              width: 0,
            ),
            borderRadius: BorderRadius.circular(100),
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
  bool showSuffixIcon;

  final TextEditingController? textEditingController;
  final int? maxLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatter;

  final EdgeInsets? textFieldPadding;
  final double? labelTextSize;
  bool obscureText;
  Iterable<String>? autofillHints;
  final bool isError;

  final TextInputType? keyboardType;

  final Function(String value)? onChanged;
  final Function(String value) validator;

  AppTextField(
      {Key? key,
      this.labelText = '',
      this.textEditingController,
      this.autofillHints,
      this.prefixIcon,
      this.suffixIcon = '',
      this.hintTextStyle,
      this.textStyle,
      this.showPrefixWidget,
      this.maxLines = 1,
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
  final FocusNode _focusNode = FocusNode();
  bool isFocus = false;

  void _onFocusChange() {
    setState(() {
      isFocus = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _focusNode.addListener(_onFocusChange);
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
                  size: widget.labelTextSize ?? 14,
                  color: Colors.black),
            ).paddingOnly(left: 3),
          (8).space(),
          TextFormField(
            smartQuotesType: SmartQuotesType.disabled,
            smartDashesType: SmartDashesType.disabled,
            enableSuggestions: false,
            enableIMEPersonalizedLearning: false,
            autocorrect: false,
            maxLength: widget.maxLength,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            maxLines: widget.maxLines,
            controller: widget.textEditingController,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            inputFormatters: widget.inputFormatter,
            focusNode: _focusNode,
            validator: (value) {
              return widget.validator(value!);
            },
            onChanged: (value) {
              textFieldValue = value;
              widget.onChanged!.call(value);
            },
            cursorColor: primaryBrown,
            style: widget.textStyle ??
                GoogleFonts.montserrat(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.black),
            obscureText: widget.obscureText,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.showSuffixIcon
                  ? widget.obscureText
                      ? Container(
                          child: GestureDetector(
                              onTap: _toggleObscured,
                              child: widget.obscureText
                                  ? Assets.icons.closeEye
                                      .svg(colorFilter: ColorFilter.mode(hintTextColor,BlendMode.srcIn))
                                      .paddingAll(3)
                                      .paddingOnly(bottom: 4)
                                  : Assets.icons.openEye
                                      .svg(colorFilter: ColorFilter.mode(hintTextColor,BlendMode.srcIn))
                                      .paddingAll(3)),
                        ).paddingOnly(right: 20)
                      : widget.showPrefixWidget
                  : widget.showPrefixWidget,
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle ??
                  GoogleFonts.montserrat(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: hintTextColor),
              /* fillColor: textFieldValue.isNotEmpty
                  ? Colors.transparent
                  : widget.isError
                      ? appBlackColor.withOpacity(0.5)
                      : (_focusNode.hasFocus)
                          ? Colors.transparent
                          : hintTextColor.withOpacity(0.2),*/
              fillColor: Colors.white,
              filled: true,
              errorStyle: const TextStyle(height: 0),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color:
                          textFieldValue.isNotEmpty ? primaryBrown : skyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: primaryBrown)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: widget.isError
                          ? Colors.red
                          : hintTextColor.withOpacity(0.2))),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                      color: widget.isError
                          ? primaryBrown
                          : Colors.black.withOpacity(0.5))),
            ),
          ),
        ],
      ),
    );
  }

  void _toggleObscured() {
    setState(() {
      widget.obscureText = !widget.obscureText;
      if (_focusNode.hasPrimaryFocus)
        return; // If focus is on text field, dont unfocus
      _focusNode.canRequestFocus = false; // Prevents focus if tap on eye
    });
  }
}
