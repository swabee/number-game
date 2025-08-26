
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_constants.dart';


class TextFieldCustom extends StatelessWidget {

  const TextFieldCustom({
    super.key,
    this.hintText,
    this.labelText,
    this.icon,
    this.prefix,
    this.prefixIcon,
    this.onChanged,
    this.width,
    this.height,
    this.marginLeft = 0,
    this.marginTop = 0,
    this.marginRight = 0,
    this.marginBottom = 0,
    this.borderRadius,
    this.alignment,
    this.keyboardType,
    this.textAlign,
    this.isOtpField,
    this.fillColor,
    this.borderColor,
    this.border,
    this.useUnderlineBorder,
    this.hintstyle,
    this.labelstyle,
    this.suffix,
    this.suffixIcon,
    this.controller,
    this.onSubmit,
    this.obscureText,
    this.textAlignVertical,
    this.borderWidth,
    this.cphorizontal,
    this.boxShadow,
  });
  final String? hintText;
  final String? labelText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final double? width;
  final double? height;
  final double marginLeft;
  final double marginTop;
  final double marginRight;
  final double marginBottom;
  final BorderRadius? borderRadius;
  final Alignment? alignment;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final Color? fillColor;
  final Color? borderColor;
  final BorderSide? border;
  final bool? useUnderlineBorder;
  final TextStyle? hintstyle;
  final TextStyle? labelstyle;
  final Widget? prefix;
  final Widget? prefixIcon;
  final bool? isOtpField;
  final Widget? suffix;
  final Widget? suffixIcon;
  final VoidCallback? onSubmit;
  final bool? obscureText;
  final TextEditingController? controller;
  final TextAlignVertical? textAlignVertical;
  final double? borderWidth;
  final double? cphorizontal;
  final List<BoxShadow>? boxShadow;

  @override
  Widget build(BuildContext context) {
    InputBorder getBorder() {
      if (useUnderlineBorder == true) {
        return UnderlineInputBorder(
          borderSide: border ?? BorderSide(color: borderColor ?? Colors.black),
        );
      } else {
        return OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(25.h),
          borderSide: border ??
              BorderSide(
                  color: borderColor ?? Colors.grey, width: borderWidth ?? 1.w,),
        );
      }
    }

    return Container(
      decoration: BoxDecoration(boxShadow: boxShadow),
      width: width ?? 379.w,
      height: height ?? 52.h,
      margin: EdgeInsets.only(
        top: marginTop,
        left: marginLeft,
        right: marginRight,
        bottom: marginBottom,
      ),
      alignment: alignment ?? Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width ?? 310.w,
          minHeight: height ?? 41.h,
        ),
        child: TextField(controller: controller,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: neutrals7,
          ),
          obscureText: obscureText ?? false,
          onSubmitted: (_) {
            if (onSubmit != null) {
              onSubmit!();
            }
          },
          expands:(obscureText!=null)?false:true,
          maxLines:(obscureText!=null)? 1:null,
          inputFormatters: isOtpField != null && isOtpField == true
              ? [
                  LengthLimitingTextInputFormatter(1),
                ]
              : null,
          textAlign: textAlign ?? TextAlign.left,
          textAlignVertical: textAlignVertical ?? TextAlignVertical.center,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintstyle ??
                TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff878787),
                ),
            labelText: labelText,
            labelStyle: labelstyle ?? const TextStyle(),
            prefixIcon: prefixIcon,
            prefix: prefix,
            suffix: suffix,
            suffixIcon: suffixIcon,
            contentPadding: EdgeInsets.symmetric(
                vertical: 8.h, horizontal: cphorizontal ?? 16.w,),
            enabledBorder: getBorder(),
            //     OutlineInputBorder(
            //   borderSide: border ??
            //       BorderSide(
            //         color: borderColor ?? Colors.black,
            //       ),
            // ),
            border: getBorder(),
            //     OutlineInputBorder(
            //   borderRadius: borderRadius ?? BorderRadius.circular(10.h),
            //   borderSide: const BorderSide(
            //     color: Colors.grey, // replace with your unfocused border color
            //   ),
            // ),
            focusedBorder: getBorder(),
            //     OutlineInputBorder(
            //   borderRadius: borderRadius ?? BorderRadius.circular(10.h),
            //   borderSide: const BorderSide(
            //     color: Colors.black, // replace with your focused border color
            //   ),
            // ),
            fillColor: fillColor,
            filled: fillColor != null ? true : false,
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }
}
