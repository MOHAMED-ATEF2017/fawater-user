import 'dart:io';

import 'package:dio/dio.dart';

class CreateInvoiceCollectData {
  String? storeId, dateInvoice, totalInvoice,storeName;
  List<Map<String, dynamic>>? products;
  File? invoiceImage;
  CreateInvoiceCollectData(
      {this.dateInvoice, this.products, this.storeId, this.totalInvoice});

  Map<String, dynamic> toJsonByDetails(String userId) => {
        "store_id": storeId,
        "date_invoice": dateInvoice,
        "total_invoice": totalInvoice,
        "user_id": userId,
        "products": products
      };
  Map<String, dynamic> toJsonByImage(String userId) => {
        "store_name": storeName,
        "date_invoice": dateInvoice,
        "total_invoice": totalInvoice,
        "id_user": userId,
        "url_pictures_purchase_invoices": invoiceImage == null
            ? null
            : MultipartFile.fromFileSync(invoiceImage!.path)
      };
}
