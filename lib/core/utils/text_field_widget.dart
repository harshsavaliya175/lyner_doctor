import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../gen/assets.gen.dart';
import '../constants/app_color.dart';
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

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final int maxLine = 1;
  FocusNode _focus = FocusNode();
  final Color fillColor = whiteColor;

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
    setState(() {

    });
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height ?? 60.w,
      child: TextFormField(
        focusNode: _focus,
        readOnly: widget.readOnly ?? false,
        onChanged: widget.onChange,
        validator: widget.validation,
        controller: widget.controller ?? TextEditingController(),
        maxLines: maxLine,
        autofocus: false,
        style: hintTextStyle(
        size: 16.sp,color: hintTextColor,weight: FontWeight.w400
        ),
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
                          color: _focus.hasFocus ? primaryBrown : hintColor,
                          fit: BoxFit.contain)
                      .paddingAll(widget.prefixPadding??12.w))
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
          fillColor: fillColor,
        ),
      ),
    );
  }
}
