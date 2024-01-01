import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';

import '../../../Models/BillDetailsModel/bill_details_model.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../gen/assets.gen.dart';
import 'fawatery_details_dialog_common_column.dart';

class ByanatALmatgarTabBody extends StatelessWidget {
  const ByanatALmatgarTabBody({
    super.key,
    required this.billDetailsModel,
    required this. id,
  });
  final BillDetailsModel billDetailsModel;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      20.verticalSpace,
      Row(
        children: [
          Text(
            billDetailsModel.storeData.first.storeName,
            style: textStyle(),
          ),
          // Text(
          //   ' (${billDetailsModel.storeData.first .address})',
          //   style: textStyle(size: 12),
          // ),
          const Spacer(),
          const Icon(
            Icons.favorite_border,
            color: AppColors.ffF05A27OrangeColor,
          )
        ],
      ),
      22.verticalSpace,
      SizedBox(
        height: 20.h,
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColors.ffF05A27OrangeColor,
            ),
            6.horizontalSpace,
            Text(
              billDetailsModel.storeData.first.address,
              style: textStyle(size: 12),
            )
          ],
        ),
      ),
      21.verticalSpace,
      SizedBox(
        height: 18.h,
        child: Row(
          children: [
            Assets.icons.clock.svg(),
            6.horizontalSpace,
            Text(
              Jiffy.parse(
                      billDetailsModel.storeData.first.dateInvoice.toString())
                  .jm,
              style: textStyle(size: 12),
            ),
            const Spacer(),
            Assets.icons.callCalling.svg(),
            6.horizontalSpace,
            Text(
              billDetailsModel.storeData.first.phone,
              style: textStyle(size: 12),
            ),
            const Spacer(),
            Assets.icons.calendar.svg(),
            6.horizontalSpace,
            Text(
              Jiffy.parse(
                      billDetailsModel.storeData.first.dateInvoice.toString())
                  .yMd,
              style: textStyle(size: 12),
            ),
          ],
        ),
      ),
      FawateryDetailsDialogCommonColumn(
        id:id,
          billDetailsModel: billDetailsModel, index: 0),
    ]);
  }
}
