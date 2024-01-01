import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/app_colors.dart';
import 'text_style.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    this.onPressed,
    this.width,
    this.height,
    this.textSize,
    this.color,
    this.textColor,
    required this.title,
    this.radius,
    this.borderColor,
  });
  final Function()? onPressed;
  final double? width, height, textSize, radius;
  final Color? color, textColor, borderColor;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
            width: width ?? 290.w,
            height: height ?? 48.h,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
              color: color ?? AppColors.ffF05A27OrangeColor,
              border:
                  Border.all(color: borderColor ?? AppColors.ffF05A27OrangeColor),
              borderRadius: BorderRadius.circular((radius ?? 12).r),
            ),
            child: Text(
              title,
              style: textStyle(color: textColor ?? Colors.white, size: textSize),
            )),
      ),
    );
  }
}
