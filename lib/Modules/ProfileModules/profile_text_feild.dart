import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';

class ProfileTextFeild extends StatelessWidget {
  const ProfileTextFeild(
      {super.key,
      required this.title,
      required this.hintText,
      this.isEnabeld = true,
      this.initialValue,required this.onSaved,required this.validator});
  final String title, hintText;
  final bool isEnabeld;
  final String? initialValue;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textStyle(size: 16),
        ),
        TextFormField(
          enableInteractiveSelection: false,
          enabled: isEnabeld,
          controller: TextEditingController(text: initialValue),
          onSaved: onSaved,
          validator: validator,
          style: textStyle(),
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.ffFEEFE9PrimaryLight),
            ),
          ),
        ),
        12.verticalSpace,
      ],
    );
  }
}
