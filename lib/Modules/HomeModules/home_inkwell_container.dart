import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';

class CreateFatoraInkwellContainer extends StatelessWidget {
  const CreateFatoraInkwellContainer({
    super.key,
    required this.title,
    required this.svg,
    this.onTap,
  });
  final String title, svg;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 1.sw,
        height: 210.h,
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 2.r)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                svg,
                height: 130.h,
              ),
            ),
            Text(
              title,
              style: textStyle(
                  color: AppColors.ffF05A27OrangeColor,
                  weight: FontWeight.w500),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('يمكنك الآن انشاء فاتورة في خطوه واحده' , style: textStyle(size: 12),),
                Icon(Icons.arrow_forward_ios , color: AppColors.ffF05A27OrangeColor , size: 15.r,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
