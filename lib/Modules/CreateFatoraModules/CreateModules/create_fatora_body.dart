import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import 'create_by_details_body.dart';
import 'create_by_image.dart';

class CreateFatoraBody extends StatelessWidget {
  const CreateFatoraBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
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
                    Text(AppStrings.createFatoraByDetails),
                    Text(AppStrings.uploadFatoraImage),
                  ]),
              const Expanded(
                child: TabBarView(
                  children: [
                    CreateFatoraByDetailsBody(),
                    CreateFatoraByImageBody(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
