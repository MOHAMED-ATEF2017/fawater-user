import 'package:fawatery_user/Models/GetAllInvoices/get_all_invoices_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

import '../../../Shared/Components/container_button.dart';
import '../../../Shared/Components/container_decoration.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import '../../../gen/assets.gen.dart';
import 'my_fatora_show_details_dialog.dart';

class FawateryListViewContainer extends StatelessWidget {
  const FawateryListViewContainer({
    super.key, required this.datum,
  });
  final GetAllInvoicesDatum datum;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
      decoration: customContainerBoxDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                datum.storeName,
                style: textStyle(weight: FontWeight.w500),
              ),
              const Spacer(),
               Icon(
          datum.favorite?      Icons.favorite:Icons.favorite_border,
                color: AppColors.ffF05A27OrangeColor,
              )
            ],
          ),
          23.verticalSpace,
          Row(
            children: [
              Assets.icons.moneys.svg(),
              6.horizontalSpace,
              Text(
                '${datum.totalInvoice} جنية',
                style: textStyle(size: 12, weight: FontWeight.w500),
              )
            ],
          ),
          21.verticalSpace,
          Row(
            children: [
              Assets.icons.calendar.svg(),
              6.horizontalSpace,
              Text(
           Jiffy.parse(    datum.dateInvoice).yMMMEdjm,
                style: textStyle(size: 12, weight: FontWeight.w500),
              ),
            /*   const Spacer(),
              Assets.icons.receiptSquare.svg(),
              6.horizontalSpace,
              Text(
                'ضمان 24 ساعة',
                style: textStyle(size: 12, weight: FontWeight.w500),
              ) */
            ],
          ),
          21.verticalSpace,
          CustomContainerButton(
            title: AppStrings.viewDetails,
            color: AppColors.ffFEEFE9PrimaryLight,
            textColor: AppColors.ffF05A27OrangeColor,
            borderColor: Colors.transparent,
            onPressed: () => Get.dialog( MyFatoraShowDetailsDialog(id: datum.invoicesId.toString(),)),
          ),
          20.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.saveAndPrint,
                style: textStyle(size: 12),
              ),
              Text(
                AppStrings.addNote,
                style: textStyle(size: 12),
              ),
              Text(
                AppStrings.sendBy,
                style: textStyle(size: 12),
              ),
            ],
          ),
          // 8.verticalSpace,
          Row(
            children: [
              SizedBox(
                  width: 24.w,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Assets.icons.documentDownload.svg(),
                  )),
              12.horizontalSpace,
              SizedBox(
                width: 24.w,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Assets.icons.printer.svg(),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 24.w,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Assets.icons.notification.svg(
                      // ignore: deprecated_member_use_from_same_package
                      color: AppColors.ffF05A27OrangeColor,
                    )),
              ),
              const Spacer(),
              SizedBox(
                width: 24.w,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Assets.icons.sms.svg()),
              ),
              12.horizontalSpace,
              SizedBox(
                width: 24.w,
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Assets.icons.whatsapp.svg()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
