import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';
import 'setting_row.dart';

class SettingBody extends StatelessWidget {
  const SettingBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.e3datadAlhesabText,
            style: textStyle(),
          ),
          //************* profile ***************** */
           SettingRow(
            title: AppStrings.e3datadAlmelafAlshaghsyText,
            svgIcon: Assets.icons.userTag.path 
          ),
          // //************ branches ***************** */
          // const SettingRow(
          //   title: AppStrings.e3dadatAlFro3,
          //   svgIcon: AppStrings.shopSvg,
          // ),
          //************* change password  ***************** */
           SettingRow(
            title: AppStrings.changePassword,
            svgIcon: Assets.icons.lock.path,
          ),
          //************* fatarat Al tanbeh  ***************** */
          //  SettingRow(
          //   title: AppStrings.fatretAltanbeh,
          //   svgIcon: Assets.icons.notification.path,
          // ),
          //************* 3dd fatarat Al tanbeh  ***************** */
          //  SettingRow(
          //   title: AppStrings.addFtaratAltanbeh,
          //   svgIcon:  Assets.icons.notification.path,
          // ),
          32.verticalSpace,
          Text(
            AppStrings.markazAlmosa3ada,
            style: textStyle(),
          ),
          //************* About App password  ***************** */
           SettingRow(
            title: AppStrings.aboutApp,
            svgIcon:  Assets.icons.note.path,
          ),
          //************* Terms and Conditions   ***************** */
           SettingRow(
            title: AppStrings.termsConditions,
            svgIcon:  Assets.icons.shieldCheck.path
          ),
          //*************  Share   ***************** */
           SettingRow(
            title: AppStrings.shareApp,
            svgIcon:  Assets.icons.share.path,
            isIcon: false,
          ),
          32.verticalSpace,
          Text(
            AppStrings.e3datadAlTatbeq,
            style: textStyle(),
          ),
          //********************* E3datad Altadbeq *************** */
           SettingRow(
            title: AppStrings.changeLanguage,
            svgIcon:  Assets.icons.languageSquare.path,
          ),
          //********************* Delete Account *************** */
           SettingRow(
            title: AppStrings.deleteAccount,
            svgIcon:  Assets.icons.profileDelete.path,
          ),
          //********************** logout out ******************** */
           SettingRow(
            title: AppStrings.logout,
            svgIcon:  Assets.icons.logout.path,
            isIcon: false,
          ),
        ],
      ),
    );
  }
}
