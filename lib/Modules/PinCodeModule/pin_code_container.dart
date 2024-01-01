import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../Screens/AuthScreens/NewPasswordScreen/new_password_screen.dart';
import '../../Screens/LocationScreen/location_screen.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';

class PinCodeContainer extends StatelessWidget {
  const PinCodeContainer({
    super.key,
    this.isFromLogin = true,
  });
  final bool isFromLogin;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.confPinCode,
              style: textStyle(size: 22),
            ),
            4.verticalSpace,
            Text(
              AppStrings.pinCodeWasSent,
              style: textStyle(),
            ),
            24.verticalSpace,
            const Pinput(
              length: 6,
              // androidSmsAutofillMethod:
              //     AndroidSmsAutofillMethod.smsUserConsentApi,
            ),
            12.verticalSpace,
            Center(
                child: Text(
              '34',
              style: textStyle(size: 12, color: AppColors.ffF05A27OrangeColor),
            )),
            Center(
                child: Text(
              AppStrings.resend,
              style: textStyle(size: 12),
            )),
            24.verticalSpace,
            Center(
              child: CustomContainerButton(
                width: 343.w,
                title: AppStrings.confirm,
                onPressed: () {
                  isFromLogin
                      ? CustomNavigation.fadeInGetToNavigateFunction(
                          const NewPasswordScreen())
                      : CustomNavigation.fadeInGetToNavigateFunction(
                          const LocationScreen());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
