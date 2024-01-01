import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';

class HomeScreenFawaterContainer extends StatelessWidget {
  const HomeScreenFawaterContainer({
    super.key,
    required this.title,
    required this.svg, required this.data,
  });
  final String title, svg , data;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 106.w,
      height: 70.h,
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 6.w),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 2.r)
          ]),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(svg),
              Text(
               data,
                style: textStyle(
                    color: AppColors.ffF05A27OrangeColor,
                    size: 16,
                    weight: FontWeight.w500),
              )
            ],
          ),
          Text(
            title,
            style: textStyle(size: 11, color: AppColors.ffF05A27OrangeColor),
          )
        ],
      ),
    );
  }
}
