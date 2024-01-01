import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Models/AllStoresModel/all_stores_model.dart';
import '../../Screens/MatgarDetailsScreen/matgar_details_screen.dart';
import '../../Shared/Components/container_decoration.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/functions/navigate_fadin.dart';
import '../../Shared/globals.dart';

class MatagerGridViewWidget extends StatelessWidget {
  const MatagerGridViewWidget({
    super.key, required this.data,
  });
  final List<AllStoresDatum> data;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: (165.5.h) / (200.w)),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {

          return InkWell(
            onTap: () => CustomNavigation.fadeInGetToNavigateFunction(
                MatgarDetailsScreen(storeData: data[index])),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: customContainerBoxDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //************* image ********** */
                  Container(
                    height: 149.5.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: DecorationImage(
                            image: NetworkImage(
                                "${BASE_URL.split('api').first}/${data[index].img}"),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fill)),
                  ),
                  4.verticalSpace,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3 كيلومتر',
                        style: textStyle(
                            color: AppColors.ff5A5D61SubText, size: 8),
                      ),
                      const Spacer(),
                      Text(
                        '4.7',
                        style: textStyle(size: 8, weight: FontWeight.w500),
                      ),
                      4.horizontalSpace,
                      Icon(
                        Icons.star,
                        color: AppColors.ffF05A27OrangeColor,
                        size: 12.r,
                      )
                    ],
                  ),
                  Text(
                    data[index].store,
                    style: textStyle(size: 11, weight: FontWeight.w500),
                  ),
                  Text(
                    data[index].address,
                    style: textStyle(
                      size: 8,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
