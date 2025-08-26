
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/app_constants.dart';


class ButtonCustom extends StatelessWidget {
  const ButtonCustom({
    required this.text,
    required this.callback,
    super.key,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.borderRadius,
    this.dontApplyMargin,
    this.isDisabled,
    this.borderSide = BorderSide.none,
    this.textStyle,
    this.margin,
    this.inProgress,
    this.padding,
    this.splashColor,
    this.isPositive,
    this.child,
    this.textColor,
  });

  final double? btnHeight;
  final double? btnWidth;
  final String text;
  final TextStyle? textStyle;
  final Color? btnColor;
  final VoidCallback? callback;
  final BorderRadius? borderRadius;
  final bool? dontApplyMargin;
  final bool? isDisabled;
  final BorderSide borderSide;
  final EdgeInsets? margin;
  final bool? inProgress;
  final EdgeInsetsGeometry? padding;
  final Color? splashColor;
  final bool? isPositive;
  final Widget? child;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(25.h),
        ),
        color: (callback == null || isDisabled == true)
            ? Colors.grey
            : primaryColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: (callback == null || isDisabled == true)
        //       ? [Colors.grey, Colors.grey]
        //       : [const Color(0xFF87CEEB), const Color(0xFF1B7A9F)],
        // ),
      ),
      margin: margin ??
          EdgeInsets.symmetric(horizontal: dontApplyMargin == true ? 0 : 24),
      height: btnHeight ?? 56.h,
      width: btnWidth ?? btnWidth,
      alignment: Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: btnColor,
          foregroundColor: splashColor ?? Colors.white24,
          padding: padding ?? const EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(25.h),
            side: borderSide,
          ),
        ),
        onPressed: (callback == null || isDisabled == true)
            ? null
            : () {
                if (inProgress == true) {
                  return;
                }
                callback!();
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (child != null) child!,
              SizedBox(width: 8.w),
              Container(
                alignment: Alignment.center,
                child: (inProgress == true)
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        text,
                        style: textStyle ??
                            TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: textColor ?? Colors.black,
                            ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
