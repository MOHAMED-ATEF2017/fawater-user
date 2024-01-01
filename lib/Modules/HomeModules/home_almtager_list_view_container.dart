import 'package:fawatery_user/Models/AllStoresModel/all_stores_model.dart';
import 'package:fawatery_user/Shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Screens/MatgarDetailsScreen/matgar_details_screen.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/functions/navigate_fadin.dart';

class HomeAlmtagerListViewContainer extends StatelessWidget {
  const HomeAlmtagerListViewContainer({
    super.key, required this.datum,
  });
  final AllStoresDatum datum;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>CustomNavigation.fadeInGetToNavigateFunction(
                MatgarDetailsScreen(storeData: datum)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 1.sw,
            height: 149.h,
            child: Image.network("${BASE_URL.split('api').first}${datum.img}"),
          ),
          4.verticalSpace,
          Row(
            children: [
              Text(
                '3 كيلومتر',
                style: textStyle(size: 8, weight: FontWeight.w500),
              ),
              const Spacer(),
              Text(
                '4.7',
                style: textStyle(size: 8, weight: FontWeight.w500),
              ),
              Icon(
                Icons.star,
                color: AppColors.ffF88F2DAccentWarning,
                size: 18.r,
              )
            ],
          ),
          Text(
            datum.store,
            style: textStyle(size: 11, weight: FontWeight.w500),
          ),
          Text(
           datum.address/*  'سوبر ماركت' */,
            style: textStyle(
              size: 8,
            ),
          ),
        ],
      ),
    );
  }
}
