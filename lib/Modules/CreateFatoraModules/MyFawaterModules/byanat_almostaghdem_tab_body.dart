import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Models/BillDetailsModel/bill_details_model.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../gen/assets.gen.dart';
import 'fawatery_details_dialog_common_column.dart';

class ByanatALmostaghdemTabBody extends StatelessWidget {
  const ByanatALmostaghdemTabBody({
    super.key,
    required this.billDetailsModel,
    required this.index, required this.id,
    // required this. userDatum,
  });
  // final InvoiceDatum invoiceDatum;
  final BillDetailsModel billDetailsModel;
  final int index;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.icons.clock.svg(),
            6.horizontalSpace,
            Text(
              billDetailsModel.userData[index].name,
              style: textStyle(size: 12),
            ),
            const Spacer(),
            Assets.icons.callCalling.svg(),
            6.horizontalSpace,
            Text(
              billDetailsModel.userData[index].phone,
              style: textStyle(size: 12),
            ),
            20.horizontalSpace
          ],
        ),
        FawateryDetailsDialogCommonColumn(id: id,
          billDetailsModel: billDetailsModel,
          index: index,
        )
      ],
    );
  }
}
