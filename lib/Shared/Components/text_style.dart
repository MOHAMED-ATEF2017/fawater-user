import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/app_colors.dart';

 TextStyle textStyle({
  Color? color,
  double? size,
  double? height,
  bool isDecorated = false,
  FontWeight? weight,
}) {
  return TextStyle(
    color: color??AppColors.ff12161CMainText,
    fontSize: (size ?? 14).sp,
    decoration: isDecorated ? TextDecoration.lineThrough : TextDecoration.none,
    fontFamily: 'NotoKufiArabic',
    fontWeight: weight??FontWeight.normal,
    height: height ?? 0,
  );
}
