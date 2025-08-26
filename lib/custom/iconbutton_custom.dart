import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonCustom extends StatelessWidget {
  const IconButtonCustom({
    // required this.text,
    required this.callback, required this.child, super.key,
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
    this.shape,
    this.alignment,
  });

  final double? btnHeight;
  final double? btnWidth;
  // final String text;
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
  final Widget child;
  final OutlinedBorder? shape;
  final AlignmentGeometry? alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: shape ??
            RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.h),),
        color:
            (callback == null || isDisabled == true) ? Colors.grey : btnColor,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: (callback == null || isDisabled == true)
        //       ? [Colors.grey, Colors.grey]
        //       : [const Color(0xFF87CEEB), const Color(0xFF1B7A9F)],
        // ),
      ),
      margin: margin ??
          EdgeInsets.symmetric(horizontal: dontApplyMargin == true ? 0 : 5),
      height: btnHeight ?? btnHeight,
      width: btnWidth ?? btnWidth,
      alignment: alignment ?? Alignment.center,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              (callback == null || isDisabled == true) ? Colors.grey : btnColor,
          foregroundColor: splashColor ?? Colors.white24,
          padding: padding ?? const EdgeInsets.all(0),
          shape: shape ??
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(10.h),
                side: borderSide,
              ),
        ),
        onPressed: (callback == null || isDisabled == true)
            ? null
            : () {
                callback!();
              },
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (inProgress == true)
                const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              // ignore: unrelated_type_equality_checks
              if (child != true) child,
            ],
          ),
        ),
      ),
    );
  }
}
