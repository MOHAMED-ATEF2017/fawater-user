import 'package:fawatery_user/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intro_slider/intro_slider.dart';

import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';
import '../AuthScreens/LoginScreen/login_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<ContentConfig> listContentConfig = [];
    double sizeIndicator = 20;
    //*********************** 1 ***************** */
    listContentConfig.add(
      ContentConfig(
        backgroundColor: Colors.white,
        widgetTitle: 0.horizontalSpace,
        widgetDescription: Column(
          children: [
            Text(AppStrings.splash1Title,
                style: textStyle(size: 25, weight: FontWeight.w500)),
            Text(
              AppStrings.splash1Desc,
              style: textStyle(size: 12, weight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        centerWidget: Container(
          width: 283.w,
          height: 342.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image:  DecorationImage(
                  image:
                   AssetImage(Assets.images.splash1.path),
                  fit: BoxFit.fill)),
        ),
      ),
    );

    //********************* 2 ******************* */
    listContentConfig.add(
      ContentConfig(
        widgetTitle: 0.horizontalSpace,
        backgroundColor: Colors.white,
        widgetDescription: Column(
          children: [
            Text(AppStrings.splash2Title,
                style: textStyle(size: 25, weight: FontWeight.w500)),
            Text(
              AppStrings.splash2Desc,
              style: textStyle(size: 12, weight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        centerWidget: Container(
          width: 283.w,
          height: 342.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image:  DecorationImage(
                  image: AssetImage(Assets.images.splash2.path),
                  fit: BoxFit.fill)),
        ),
      ),
    );

    //**************** 3 *********************** */
    listContentConfig.add(
      ContentConfig(
        widgetTitle: 0.horizontalSpace,
        backgroundColor: Colors.white,
        widgetDescription: Column(
          children: [
            Text(AppStrings.splash3Title,
                style: textStyle(size: 25, weight: FontWeight.w500)),
            Text(
              AppStrings.splash3Desc,
              style: textStyle(size: 12, weight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            CustomContainerButton(
              title: AppStrings.letsStart,
              onPressed: () {
                CustomNavigation.fadeInGetOffAllNavigateFunction(
                    const LoginScreen());
              },
            )
          ],
        ),
        marginDescription: const EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 20.0,
          bottom: 70.0,
        ),
        centerWidget: Container(
          width: 283.w,
          height: 342.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image:  DecorationImage(
                  image: AssetImage(Assets.images.splash3.path),
                  fit: BoxFit.fill)),
        ),
      ),
    );

    Widget renderNextBtn() {
      return const CustomContainerButton(
        title: AppStrings.next,
        radius: 12,
        height: 500,
      );
    }

    Widget renderSkipBtn() {
      return const CustomContainerButton(
        title: AppStrings.skip,
        onPressed: null,
        textColor: AppColors.ffF05A27OrangeColor,
        radius: 12,
        color: Colors.white,
      );
    }

    return Scaffold(
        body: IntroSlider(
      key: UniqueKey(),
      listContentConfig: listContentConfig,
      renderSkipBtn: renderSkipBtn(),
      renderNextBtn: renderNextBtn(),
      nextButtonStyle: ButtonStyle(
          padding: MaterialStatePropertyAll(
              EdgeInsetsDirectional.only(start: 0, end: 16.w))),
      isShowDoneBtn: false,
      // Indicator
      indicatorConfig: IndicatorConfig(
        sizeIndicator: sizeIndicator,
        indicatorWidget: Container(
          width: sizeIndicator,
          height: 10.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.ffFEEFE9PrimaryLight),
        ),
        activeIndicatorWidget: Container(
          width: sizeIndicator,
          height: 10.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: AppColors.ffF05A27OrangeColor),
        ),
        spaceBetweenIndicator: 10.w,
        typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
      ),

      // Scroll behavior
      // isAutoScroll: true,
      // isLoopAutoScroll: true,
      curveScroll: Curves.bounceIn,
    ));
  }
}
