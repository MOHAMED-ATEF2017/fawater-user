// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package

import 'package:flutter/material.dart';

import '../../Controllers/MainScreenController/main_screen_controller.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';

class MainScreenBottomNavigationBar extends StatelessWidget {
  const MainScreenBottomNavigationBar({
    super.key,
    required this.controller,
  });
  final MainScreenController controller;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        currentIndex: controller.currentIndex,
        onTap: (value) {
          controller.changeCurrentIndex(value);
        },
        showSelectedLabels: true,
        type: BottomNavigationBarType.shifting,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.ffF05A27OrangeColor,
        unselectedItemColor: AppColors.ff5A5D61SubText,
        selectedLabelStyle: textStyle(),
        unselectedLabelStyle: textStyle(size: 12),
        backgroundColor: Colors.white,
        items: [
          //*********** home *********** */
          BottomNavigationBarItem(
            icon: Assets.icons.home.svg(
              color: controller.currentIndex == 0
                  ? AppColors.ffF05A27OrangeColor
                  : AppColors.ff5A5D61SubText,
            ),
            label: AppStrings.homeTab,
          ),

          //************ favorite ************ */
          BottomNavigationBarItem(
              icon: Icon(controller.currentIndex == 1
                  ? Icons.favorite
                  : Icons.favorite_border),
              label: AppStrings.favoriteTab),

          //************* notification ************ */
          BottomNavigationBarItem(
              icon: Assets.icons.notification.svg(
                color: controller.currentIndex == 2
                    ? AppColors.ffF05A27OrangeColor
                    : AppColors.ff5A5D61SubText,
              ),
              label: AppStrings.notificationTab),

          //************* setting ********** */
          BottomNavigationBarItem(
              icon: Assets.icons.setting2.svg(
                color: controller.currentIndex == 3
                    ? AppColors.ffF05A27OrangeColor
                    : AppColors.ff5A5D61SubText,
              ),
              label: AppStrings.settingTab),
        ]);
  }
}
