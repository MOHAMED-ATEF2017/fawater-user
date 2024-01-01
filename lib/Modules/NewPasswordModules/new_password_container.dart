import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Components/auth_text_field.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/constant_strings.dart';

class NewPasswordContainer extends StatelessWidget {
  const NewPasswordContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 375.w,
      height: 734.h,
      padding: EdgeInsets.only(
        left: 16.w,
        right: 16.w,
        top: 24.h,
      ),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            AppStrings.newPassword,
            style: textStyle(size: 22),
          ),
          4.verticalSpace,
          Text(
            AppStrings.interNewPassword,
            style: textStyle(),
          ),
          24.verticalSpace,
          AuthTextField(
            onSaved: (p0){},
            validator: (p0){
              return null;
            },
            title: AppStrings.newPassword,
            titleSize: 16,
            hintText: AppStrings.interNewPassword.split('الخا').first,
          ),
          12.verticalSpace,
           AuthTextField(
            onSaved: (p0){},

validator: (p0){
  return null;
},            title: AppStrings.reInterNewPassword,
            titleSize: 16,
            hintText: AppStrings.reInterNewPasswordHere,
          ),
          24.verticalSpace,
          Center(
            child: CustomContainerButton(
              width: 343.w,
              title: AppStrings.save,
              onPressed: () {},
            ),
          )
        ]),
      ),
    );
  }
}
