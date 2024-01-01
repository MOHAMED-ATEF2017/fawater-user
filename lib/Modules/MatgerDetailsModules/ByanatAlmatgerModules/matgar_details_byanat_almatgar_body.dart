import 'package:fawatery_user/Models/AllStoresModel/all_stores_model.dart';
import 'package:fawatery_user/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import 'byanat_almatgar_altfasel_body.dart';
import 'byanat_almatgar_rating_body.dart';

class MatgarDetailsByanatAlmatgarBody extends StatelessWidget {
  const MatgarDetailsByanatAlmatgarBody({
    super.key,
    required this. storeData,
  });
  final AllStoresDatum storeData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Container(
            width: 1.sw,
            height: 188.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(Assets.images.splash1.path),
                  fit: BoxFit.fill,
                )),
          ),
          12.verticalSpace,
          Text(
            'سوبر ماركت',
            style: textStyle(size: 12),
          ),
          Text(
           storeData.store,
            style: textStyle(size: 18, weight: FontWeight.w500),
          ),
          12.verticalSpace,
          DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelStyle: textStyle(color: AppColors.ffF05A27OrangeColor),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: 35.w,
                    ),
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    indicatorWeight: 4,
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: AppColors.ffC1C2C3Icons,
                    labelColor: AppColors.ffF05A27OrangeColor,
                    indicatorColor: AppColors.ffF05A27OrangeColor,
                    labelPadding: EdgeInsets.only(bottom: 10.h),
                    tabs: const [
                      Text(AppStrings.details),
                      Text(AppStrings.rate),
                    ],
                  ),
                  SizedBox(
                    height: .5.sh - 55.h,
                    child:  TabBarView(children: [
                      ByanatAlmatgarAltfaselBody(storeData:storeData),
                      ByanatAlmatgarRatingBody(storeId: storeData.id.toString(),)
                    ]),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
