
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jiffy/jiffy.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../Models/BillDetailsModel/bill_details_model.dart';

abstract class CreatePdfPage {
  static pw.Page createFatoraPdf(BillDetailsModel billDetailsModel, int index,
    ByteData data, ByteData fontFallBackData) {
  return pw.Page(
      pageFormat: PdfPageFormat.a4,
     
      build: (pw.Context context) => pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: <pw.Widget>[
                  pw.Center(
                    child: pw.Text(
                        ' Invoice Number : ${billDetailsModel.invoiceData[index].numberInvoices}',
                        style: pw.TextStyle(
                          font: pw.Font.ttf(data),
                          fontFallback: [
                            pw.Font.ttf(fontFallBackData),
                          ],
                          color: PdfColor.fromHex('12161C'),
                          fontSize: 14.sp,
                          fontWeight: pw.FontWeight.normal,
                        )),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(billDetailsModel.storeData[index].storeName,
                      style: pw.TextStyle(
                        font: pw.Font.ttf(data),
                        fontFallback: [
                          pw.Font.ttf(fontFallBackData),
                        ],
                        color: PdfColor.fromHex('12161C'),
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.normal,
                      )),
                  pw.SizedBox(height: 10),
                  pw.Text(billDetailsModel.storeData[index].address,
                      style: pw.TextStyle(
                        font: pw.Font.ttf(data),
                        fontFallback: [
                          pw.Font.ttf(fontFallBackData),
                        ],
                        color: PdfColor.fromHex('12161C'),
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.normal,
                      )),
                  pw.SizedBox(height: 10),
                  pw.Text(billDetailsModel.storeData[index].phone,
                      style: pw.TextStyle(
                        font: pw.Font.ttf(data),
                        fontFallback: [
                          pw.Font.ttf(fontFallBackData),
                        ],
                        color: PdfColor.fromHex('12161C'),
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.normal,
                      )),

                  pw.Text(
                      Jiffy.parseFromDateTime(
                              billDetailsModel.storeData[index].dateInvoice)
                          .yMMMEdjm,
                      style: pw.TextStyle(
                        font: pw.Font.ttf(data),
                        fontFallback: [
                          pw.Font.ttf(fontFallBackData),
                        ],
                        color: PdfColor.fromHex('12161C'),
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.normal,
                      )),

                  pw.Expanded(
                      child: pw.ListView.separated(
                          itemBuilder: (context, index) {
                            return pw.Column(children: [
                              pw.Text(
                                  billDetailsModel
                                      .productData[index].productsName,
                                  style: pw.TextStyle(
                                    font: pw.Font.ttf(data),
                                    fontFallback: [
                                      pw.Font.ttf(fontFallBackData),
                                    ],
                                    color: PdfColor.fromHex('12161C'),
                                    fontSize: 14.sp,
                                    fontWeight: pw.FontWeight.normal,
                                  )),
                              pw.SizedBox(height: 10.h),
                              pw.Text(
                                  billDetailsModel
                                      .productData[index].productQuantity,
                                  style: pw.TextStyle(
                                    font: pw.Font.ttf(data),
                                    fontFallback: [
                                      pw.Font.ttf(fontFallBackData),
                                    ],
                                    color: PdfColor.fromHex('12161C'),
                                    fontSize: 14.sp,
                                    fontWeight: pw.FontWeight.normal,
                                  )),
                              pw.SizedBox(height: 10.h),
                              pw.Text(
                                  billDetailsModel
                                      .productData[index].productPrice,
                                  style: pw.TextStyle(
                                    font: pw.Font.ttf(data),
                                    fontFallback: [
                                      pw.Font.ttf(fontFallBackData),
                                    ],
                                    color: PdfColor.fromHex('12161C'),
                                    fontSize: 14.sp,
                                    fontWeight: pw.FontWeight.normal,
                                  )),
                              pw.SizedBox(height: 10.h),
                            ]);
                          },
                          separatorBuilder: (context, index) {
                            return pw.SizedBox(height: 10.h);
                          },
                          itemCount: billDetailsModel.productData.length)),
                  pw.SizedBox(height: 10),
                  pw.Divider(), pw.SizedBox(height: 10),
                  pw.Text(billDetailsModel.userData.first.name,
                      style: pw.TextStyle(
                        font: pw.Font.ttf(data),
                        fontFallback: [
                          pw.Font.ttf(fontFallBackData),
                        ],
                        color: PdfColor.fromHex('12161C'),
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.normal,
                      )),
                  pw.SizedBox(height: 10),
                  pw.Text(billDetailsModel.userData.first.phone,
                      style: pw.TextStyle(
                        font: pw.Font.ttf(data),
                        fontFallback: [
                          pw.Font.ttf(fontFallBackData),
                        ],
                        color: PdfColor.fromHex('12161C'),
                        fontSize: 14.sp,
                        fontWeight: pw.FontWeight.normal,
                      )),
                  pw.SizedBox(height: 10),
                  // pw.Text(billDetailsModel.),
                ]),
          ));
}

}
