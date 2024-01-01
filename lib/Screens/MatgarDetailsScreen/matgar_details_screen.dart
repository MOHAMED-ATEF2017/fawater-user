import 'package:fawatery_user/Models/AllStoresModel/all_stores_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Modules/MatgerDetailsModules/ByanatAlmatgerModules/matgar_details_byanat_almatgar_body.dart';
import '../../Modules/MatgerDetailsModules/FawateryModules/matgar_details_fawatery_body.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';

class MatgarDetailsScreen extends StatelessWidget {
  const MatgarDetailsScreen({super.key, required this.storeData});
  final AllStoresDatum storeData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 1.sh,
          child: DefaultTabController(
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
                    Text(AppStrings.fawatery),
                    Text(AppStrings.matgarInformation),
                  ],
                ),
                Expanded(
                    child: TabBarView(clipBehavior: Clip.none, children: [
                   MatgarDetailsFawateryBody(storeId: storeData.id.toString()),
                  MatgarDetailsByanatAlmatgarBody(storeData: storeData)
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
