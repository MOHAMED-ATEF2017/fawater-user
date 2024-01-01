import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Shared/Components/auth_text_field.dart';
import '../../../Shared/Components/container_button.dart';
import '../../../Shared/Components/text_style.dart';
import '../../Screens/AuthScreens/PinCodeScreen/pin_code_screen.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';

class ForgetPasswordContainer extends StatelessWidget {
  const ForgetPasswordContainer({
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
            AppStrings.forgetPassword.split('؟').first,
            style: textStyle(size: 22),
          ),
          4.verticalSpace,
          Text(
            AppStrings.interInformation,
            style: textStyle(),
          ),
          24.verticalSpace,
           AuthTextField(
            titleSize: 16,
            title: AppStrings.phonNumber,
            hintText: AppStrings.phoneHint,
            isPhone: true,
            onSaved: (p0) {},
            validator: (p0){
              return null;
            },
          ),
          4.verticalSpace,
          Text(
            AppStrings.backByEmail,
            style: textStyle(size: 12, color: AppColors.ffC1C2C3Icons),
          ),
          24.verticalSpace,
          Center(
            child: CustomContainerButton(
              width: 343.w,
              title: AppStrings.send,
              onPressed: () {
                CustomNavigation.fadeInGetToNavigateFunction(
                    const PinCodeScreen());
              },
            ),
          ),
          12.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.doYouHaveAccount,
                style: textStyle(size: 12),
              ),
              InkWell(
                onTap: () => Get.back(),
                child: Text(
                  AppStrings.login,
                  style:
                      textStyle(size: 12, color: AppColors.ffF05A27OrangeColor),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
