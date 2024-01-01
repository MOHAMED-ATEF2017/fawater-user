import 'package:fawatery_user/Models/BillDetailsModel/bill_details_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'bill_details_event.dart';
import 'bill_details_state.dart';

class BillDetailsBloc extends Bloc<BillDetailsEvent, BillDetailsStates> {
  ServerGate serverGate = ServerGate.i;
  BillDetailsBloc() : super(BillDetailsStates()) {
    on<BillDetailsEventStart>((event, emit) async {
      emit(BillDetailsStateStart());

      CustomResponse response = await getBillDetailsData(
        id: event.id,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        BillDetailsModel billDetailsModel =
            BillDetailsModel.fromJson(response.response!.data);
        if (billDetailsModel.status == 200) {
          emit(BillDetailsStateSuccess(billDetailsModel: billDetailsModel));
        } else {
          emit(BillDetailsStateFailed(
            msg: billDetailsModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(BillDetailsStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(BillDetailsStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(BillDetailsStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(BillDetailsStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> getBillDetailsData({
    required String id,
  }) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
// withoutHeader: true,
      headers: headers,
      url: 'get_purchase_invoices_details?invoices_id=$id',
    );
    return response;
  }
}
