import 'package:fawatery_user/Controllers/HomeBloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Screens/AllMatagerScreen/all_matager_screen.dart';
import '../../Screens/creatBillsScreen/creat_bills_screen.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';
import '../../gen/assets.gen.dart';
import 'home_alfwater_list_view.dart';
import 'home_almatager_list_view.dart';
import 'home_inkwell_container.dart';
import 'home_my_point_container.dart';

class HomeRemainingSingleChildScrollView extends StatelessWidget {
  const HomeRemainingSingleChildScrollView({
    super.key, required this. homeBloc,
  });
    final HomeBloc homeBloc ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 20.h),
      //*************** remaining screen **************** */
      child: Column(
        children: [
          28.verticalSpace,

          //******************  inkwell container ****************** */
          CreateFatoraInkwellContainer(
            svg:  Assets.icons.invoiceAmico.path,
            title: AppStrings.creatFatora,
            onTap: () {
              CustomNavigation.fadeInGetToNavigateFunction(
                  const CreateBillsScreen());
                  // Container());
            },
          ),
          24.verticalSpace,

          //****************** my points container */
           HomeMyPointContainer(homeBloc:homeBloc),

          24.verticalSpace,

          //************** Alfwater Listview **************** */
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              AppStrings.alfwater,
              style: textStyle(size: 18, color: AppColors.ff12161CMainText),
            ),
            Text(
              AppStrings.showMore,
              style: textStyle(size: 12, color: AppColors.ffF05A27OrangeColor),
            ),
          ]),
          const HomeAlfwaterListView(),
          24.verticalSpace,
          //**************** المتاجر ****************** */
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.almatager,
                style: textStyle(size: 18, color: AppColors.ff12161CMainText),
              ),
              InkWell(
                onTap: () => CustomNavigation.fadeInGetToNavigateFunction(
                    const AllMatagerScreen()),
                child: Text(
                  AppStrings.showMore,
                  style:
                      textStyle(size: 12, color: AppColors.ffF05A27OrangeColor),
                ),
              ),
            ],
          ),
          24.verticalSpace,
          //************** المتاجر Listview **************** */
          const HomeAlmatagerListView(),
          .35.sh.verticalSpace
        ],
      ),
    );
  }
}
