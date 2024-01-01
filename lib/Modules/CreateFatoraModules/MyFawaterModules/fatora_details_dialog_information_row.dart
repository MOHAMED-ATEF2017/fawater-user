import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';

class FatoraDetailsDialogInformationRow extends StatelessWidget {
  const FatoraDetailsDialogInformationRow({
    super.key,
    required this.assetName,
    required this.title,
    required this.data,
  });
  final String assetName, title, data;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(assetName),
            6.horizontalSpace,
            Text(
              title,
              style: textStyle(size: 12, weight: FontWeight.w500),
            ),
            const Spacer(),
            Text(
              data,
              style: textStyle(
                  size: 12,
                  weight: FontWeight.w500,
                  color: AppColors.ff5A5D61SubText),
            )
          ],
        ),
        6.verticalSpace
      ],
    );
  }
}

