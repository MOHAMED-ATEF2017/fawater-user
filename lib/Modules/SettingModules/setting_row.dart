// ignore_for_file: deprecated_member_use

import 'package:fawatery_user/Controllers/LogoutBloc/logout_bloc.dart';
import 'package:fawatery_user/Controllers/LogoutBloc/logout_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../Screens/AboutScreen/about_screen.dart';
import '../../Screens/ChangePasswordScreen/change_password_screen.dart';
import '../../Screens/ProfileScreen/profile_screen.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';
import '../../gen/assets.gen.dart';

import 'package:kiwi/kiwi.dart' as kiwi;

class SettingRow extends StatelessWidget {
  const SettingRow({
    super.key,
    required this.svgIcon,
    required this.title,
    this.isIcon = true,
  });
  final String svgIcon, title;
  final bool isIcon;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTapFunction,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          child: Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColors.ffFEEFE9PrimaryLight),
                child: SvgPicture.asset(
                  svgIcon,
                  color: AppColors.ffF05A27OrangeColor,
                ),
              ),
              12.horizontalSpace,
              Text(
                title,
                style: textStyle(
                    color: title == AppStrings.logout
                        ? AppColors.ffFE92727AccentDanger
                        : null),
              ),
              const Spacer(),
              if (isIcon)
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColors.ffF05A27OrangeColor,
                  size: 15.r,
                )
            ],
          ),
        ),
        const Divider(color: AppColors.ffFEEFE9PrimaryLight, thickness: 1),
      ],
    );
  }

  void onTapFunction() {
    //************ profile screen******************** */

    if (svgIcon == Assets.icons.userTag.path) {
      CustomNavigation.fadeInGetToNavigateFunction(const ProfileScreen());
    }
    //****************** change password **************** */

    if (svgIcon == Assets.icons.lock.path) {
      CustomNavigation.fadeInGetToNavigateFunction(
          const ChangePasswordScreen());
    }
    if (svgIcon == Assets.icons.note.path) {
      //***************** about app *********************** */
      CustomNavigation.fadeInGetToNavigateFunction(const AboutScreen());
    }
    if (svgIcon == Assets.icons.shieldCheck.path) {
      //******************** terms and conditions *********************** */
    }
    if (svgIcon == Assets.icons.share.path) {
      //*********************** share app ********************* */
    }
    if (svgIcon == Assets.icons.languageSquare.path) {
      //*************** change language *************** */
    }
    if (svgIcon == Assets.icons.profileDelete.path) {
      //************** delet account ****************** */
      Get.dialog(const DeleteAccountDialogBody());
    }
    if (svgIcon == Assets.icons.logout.path) {
      //************** logout ******************* */
      Get.dialog(const LogoutDialogBody());
    }
  }
}

class LogoutDialogBody extends StatelessWidget {
  const LogoutDialogBody({super.key});

  @override
  Widget build(BuildContext context) {
    final LogoutBloc logoutBloc = kiwi.KiwiContainer().resolve<LogoutBloc>();
    return Container(
      width: 335.w,
      height: 186.h,
      margin: EdgeInsets.symmetric(vertical: .36.sh, horizontal: .05.sw),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.areYouSureLogout,
            style: textStyle(
              size: 16,
              weight: FontWeight.w500,
              color: AppColors.ffF05A27OrangeColor,
            ),
          ),
          12.verticalSpace,
          Text(
            AppStrings.logoutDialogWarning,
            style: textStyle(size: 12),
          ),
          24.verticalSpace,
          BlocBuilder(
            bloc: logoutBloc,
            builder: (context, state) {
              return Row(
                children: [
                  CustomContainerButton(
                    title: AppStrings.logout,
                    onPressed: () {
                      logoutBloc.add(LogoutEventStart());
                    },
                    width: 149.5.w,
                  ),
                  const Spacer(),
                  CustomContainerButton(
                    title: AppStrings.cancel,
                    onPressed: () {
                      Get.back();
                    },
                    width: 149.5.w,
                    color: Colors.white,
                    textColor: AppColors.ffF05A27OrangeColor,
                    borderColor: Colors.transparent,
                  ),
                ],
              );
            },
          )
        ],
      ),
    );
  }
}

class DeleteAccountDialogBody extends StatelessWidget {
  const DeleteAccountDialogBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 186.h,
      margin: EdgeInsets.symmetric(vertical: .33.sh, horizontal: .05.sw),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(4.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.areYouSureDeleteAccount,
            style: textStyle(
              size: 16,
              weight: FontWeight.w500,
              color: AppColors.ffF05A27OrangeColor,
            ),
          ),
          12.verticalSpace,
          Text(
            AppStrings.deleteAccountDialogWarning,
            style: textStyle(size: 12),
          ),
          24.verticalSpace,
          Row(
            children: [
              CustomContainerButton(
                title: AppStrings.delete,
                onPressed: () {},
                width: 149.5.w,
              ),
              const Spacer(),
              CustomContainerButton(
                title: AppStrings.cancel,
                onPressed: () {
                  Get.back();
                },
                width: 149.5.w,
                color: Colors.white,
                textColor: AppColors.ffF05A27OrangeColor,
                borderColor: Colors.transparent,
              ),
            ],
          )
        ],
      ),
    );
  }
}
