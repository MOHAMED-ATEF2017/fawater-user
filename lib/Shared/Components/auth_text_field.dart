import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Constants/app_colors.dart';
import 'text_style.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    this.hintText,
    this.isPhone = false,
    required this.title,
    this.titleSize,
    required this.onSaved,
    required this.validator,
  });
  final String? hintText;
  final String title;
  final bool isPhone;
  final double? titleSize;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle(size: titleSize ?? 22),
        ),
        4.verticalSpace,
        TextFormField(
          enableInteractiveSelection: false,
          onSaved: onSaved,
          validator: validator,
          keyboardType: isPhone ? TextInputType.phone : null,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: AppColors.ffC1C2C3Icons),
                  borderRadius: BorderRadius.circular(12.r)),
              hintText: hintText,
              alignLabelWithHint: true,
              contentPadding: EdgeInsetsDirectional.only(start: 12.w),
              hintStyle: textStyle(color: AppColors.ffC1C2C3Icons),
              prefixIconConstraints: BoxConstraints.tight(Size(41.w, 30.h)),
              prefixIcon: isPhone
                  ? Text(
                      '\t\t+20',
                      style: textStyle(color: AppColors.ffC1C2C3Icons),
                    )
                  : null),
        ),
      ],
    );
  }
}
