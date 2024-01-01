import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Shared/Constants/app_colors.dart';
import '../../gen/assets.gen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
        preferredSize: Size(1.sw, 166.h),
        child: Container(
          height: 166.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12.r),
                  bottomRight: Radius.circular(12.r)),
              color: AppColors.ffF05A27OrangeColor,
              image:  DecorationImage(
                  image: AssetImage(Assets.images.dots.path), fit: BoxFit.fill)),
          // child: ima,
        ));
  }
}

