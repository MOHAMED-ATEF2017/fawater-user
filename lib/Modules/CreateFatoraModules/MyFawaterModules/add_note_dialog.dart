
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Shared/API/header.dart';
import '../../../Shared/API/server_gate.dart';
import '../../../Shared/Components/container_button.dart';
import '../../../Shared/Components/container_decoration.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/constant_strings.dart';
import '../../../Shared/globals.dart';

class AddFatoraNoteDialog extends StatelessWidget {
  const AddFatoraNoteDialog({
    super.key,
    required this.invoiceId,
  });
  final String invoiceId;
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Material(
      color: Colors.transparent,
      child: Container(
        margin:
            EdgeInsets.only(right: 20.w, left: 20.w, bottom: 350.h, top: 150.h),
        padding: const EdgeInsets.all(15),
        decoration: customContainerBoxDecoration(),
        child: Column(children: [
          Text(
            'أضف الملاحظة',
            style: textStyle(size: 20),
          ),
          20.verticalSpace,
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(border: OutlineInputBorder()),
          ),
          const Spacer(),
          CustomContainerButton(
            title: AppStrings.addNote,
            onPressed: () async {
              await sendNoteFunction(controller);
            },
          )
        ]),
      ),
    );
  }

  Future<void> sendNoteFunction(TextEditingController controller) async {
    Get.back();
    ServerGate serverGate = ServerGate.i;
    String? token = await InitStorage.storage
        .read(key: AppStrings.storageTokenKey);
    String? userId = await InitStorage.storage
        .read(key: AppStrings.storageUserIdKey);
    Map<String, dynamic> headers = await headersMap(token!);
    await serverGate.sendToServer(
        url: 'add_purchase_invoices_notes',
        headers: headers,
        body: {
          'notes': controller.text,
          'user_id': userId,
          'invoices_id': invoiceId
        }).then((value) {
      if (value.success) {
        Get.snackbar('Success', value.msg);
      } else {
        Get.snackbar('ERRORS', value.msg);
      }
    });
  }
}
