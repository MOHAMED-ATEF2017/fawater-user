import 'dart:io';

import 'package:fawatery_user/Modules/CreateFatoraModules/MyFawaterModules/creat_pdf_page.dart';
import 'package:fawatery_user/Shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../Models/BillDetailsModel/bill_details_model.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import '../../../gen/assets.gen.dart';
import 'add_note_dialog.dart';
import 'fatora_details_dialog_information_row.dart';

class FawateryDetailsDialogCommonColumn extends StatelessWidget {
  const FawateryDetailsDialogCommonColumn(
      {super.key,
      required this.billDetailsModel,
      required this.index,
      required this.id});
  final BillDetailsModel billDetailsModel;
  final int index;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        20.verticalSpace,
        const Divider(),
        20.verticalSpace,

        //************** fatora no***************** */
        FatoraDetailsDialogInformationRow(
          assetName: Assets.icons.receipt2.path,
          title: AppStrings.fatoraNo,
          data: billDetailsModel.invoiceData[index].numberInvoices,
        ),
        //************* safi alse3r ************ */
        /*  FatoraDetailsDialogInformationRow(
          assetName: Assets.icons.moneys.path,
          title: AppStrings.safiAlse3r,
          data: '18000 جنية',
        ), */
        //************* tax *************** */
        /*  FatoraDetailsDialogInformationRow(
          assetName: Assets.icons.moneyAdd.path,
          title: AppStrings.tax,
          data: '500 جنية',
        ), */
        //************** other masaref **************** */
        /*  FatoraDetailsDialogInformationRow(
          assetName: Assets.icons.receiptAdd.path,
          title: AppStrings.otherMasrofat,
          data: '500 جنية',
        ), */
        //************* egmaly alde3r ******************* */
        FatoraDetailsDialogInformationRow(
          assetName: Assets.icons.receiptItem.path,
          title: AppStrings.egmalyAlse3r,
          data: '${billDetailsModel.invoiceData[index].totalInvoice} جنية',
        ),
        /*  Row(
          children: [
            Assets.icons.receiptSquare.svg(),
            6.horizontalSpace,
            Text(
              'يمكن استبدال المنتج بمنتج اخر بنفس سعر منتجك',
              style: textStyle(size: 12),
            )
          ],
        ), */
        20.verticalSpace,
        const Divider(),
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
        Row(
          children: [
            SizedBox(
              width: 24.w,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    generatePDF();
                  },
                  icon: Assets.icons.documentDownload.svg()),
            ),
            12.horizontalSpace,
            SizedBox(
              width: 24.w,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    generatePDF();
                  },
                  icon: Assets.icons.printer.svg()),
            ),
            const Spacer(),
            SizedBox(
              width: 24.w,
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.dialog(AddFatoraNoteDialog(
                      invoiceId: id,
                    ));
                  },
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
    );
  }

  Future<void> generatePDF() async {
    final pdf = pw.Document();
    ByteData fontData =
        await rootBundle.load('assets/fonts/NotoKufiArabic-Regular.ttf');
    ByteData fontFallBackData =
        await rootBundle.load('assets/fonts/Montserrat-Regular.ttf');
    pdf.addPage(CreatePdfPage.createFatoraPdf(
        billDetailsModel, index, fontData, fontFallBackData));
    final appDocumentsDirectory = await getDownloadsDirectory();
    appDocumentsDirectory!.createSync(recursive: true);
    final filePath =
        '${appDocumentsDirectory.path}/${billDetailsModel.invoiceData[index].numberInvoices}.pdf';

    try {
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await Permission.storage.request().isGranted;
      // OpenFile.open(filePath);
    } catch (e) {
      logger.e(e);
    }
    // if (file.existsSync()) {
    // } else {
    //   logger.e("message");
    // }
  }
}
