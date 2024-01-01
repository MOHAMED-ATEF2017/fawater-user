import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/BillDetailsModel/bill_details_model.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import 'fawatery_details_dialog_common_column.dart';

class ByanatAlmontagTabBody extends StatelessWidget {
  const ByanatAlmontagTabBody({
    super.key,
    required this.billDetailsModel, required this.id,
  });
  final BillDetailsModel billDetailsModel;
    final String id;

  // final List<ProductDatum> productData;
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.verticalSpace,
        SizedBox(
          height: 100.h,
          child: Scrollbar(
            controller: scrollController,
            trackVisibility: true,
            thickness: 13.h,
            thumbVisibility: true,
            radius: Radius.circular(18.r),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              shrinkWrap: true,
              itemCount: billDetailsModel.productData.length,
              separatorBuilder: (BuildContext context, int index) {
                return 6.horizontalSpace;
              },
              itemBuilder: (BuildContext context, int index) {
                var data = billDetailsModel.productData[index];
                return SizedBox(
                  height: 76.h,
                  width: 180.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.productsName,
                        style: textStyle(),
                      ),
                      Text(
                        data.productQuantity,
                        style: textStyle(
                            size: 12, color: AppColors.ff5A5D61SubText),
                      ),
                      Text(
                        '${data.productPrice} جنية',
                        style: textStyle(
                            size: 12, color: AppColors.ff5A5D61SubText),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        FawateryDetailsDialogCommonColumn(
          id: id,
          billDetailsModel: billDetailsModel,
          index: 0,
        )
      ],
    );
  }
}
