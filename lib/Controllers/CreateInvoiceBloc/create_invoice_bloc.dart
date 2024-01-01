import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_collect_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Screens/creatBillsScreen/creat_bills_screen.dart';
import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'create_invoice_event.dart';
import 'create_invoice_state.dart';

class CreateInvoiceBloc extends Bloc<CreateInvoiceEvent, CreateInvoiceStates> {
  ServerGate serverGate = ServerGate.i;
  CreateInvoiceBloc() : super(CreateInvoiceStates()) {
    //************** Create by details *****************/
    on<CreateInvoiceByDetailsEventStart>((event, emit) async {
      emit(CreateInvoiceByDetailsStateStart());

      CustomResponse response = await sendCreateInvoiceByDetailsData(
        collectData: event.createInvoiceCollectData,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        if (response.response!.data['status'] == 200) {
          emit(CreateInvoiceByDetailsStateSuccess());
          Get.snackbar('Success', response.response!.data['message']);
          Get.dialog(const AddFatoraSuccessDialogeContainer());
        } else {
          emit(CreateInvoiceStateFailed(
            msg: response.response!.data['message'],
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(CreateInvoiceStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(CreateInvoiceStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(CreateInvoiceStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(CreateInvoiceStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });

    //*************** Create by image **************** */
    on<CreateInvoiceByImageEventStart>((event, emit) async {
      emit(CreateInvoiceByImageStateStart());

      CustomResponse response = await sendCreateInvoiceByImageData(
        collectData: event.createInvoiceCollectData,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        if (response.response!.data['status'] == 200) {
          emit(CreateInvoiceByImageStateSuccess());
          Get.snackbar('Success', response.response!.data['message']);
          Get.dialog(const AddFatoraSuccessDialogeContainer());
        } else {
          emit(CreateInvoiceStateFailed(
            msg: response.response!.data['message'],
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(CreateInvoiceStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(CreateInvoiceStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(CreateInvoiceStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(CreateInvoiceStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

//**************** by details *********** */
  Future<CustomResponse> sendCreateInvoiceByDetailsData({
    required CreateInvoiceCollectData collectData,
  }) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? usrID =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);

    logger.t(collectData.toJsonByDetails(usrID!));
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'create_purchase_invoices_details',
        body: collectData.toJsonByDetails(usrID));
    return response;
  }

//**************** by Image *********** */
  Future<CustomResponse> sendCreateInvoiceByImageData({
    required CreateInvoiceCollectData collectData,
  }) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? usrID =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);

    logger.t(collectData.toJsonByImage(usrID!));
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'create_purchase_invoices',
        body: collectData.toJsonByImage(usrID));
    return response;
  }
}
