import 'package:fawatery_user/Models/GetAllInvoices/get_all_invoices_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'get_my_fawater_event.dart';
import 'get_my_fawater_state.dart';

class GetMyStoreFawaterBloc
    extends Bloc<GetMyStoreFawaterEvent, GetMyStoreFawaterStates> {
  ServerGate serverGate = ServerGate.i;
  GetMyStoreFawaterBloc() : super(GetMyStoreFawaterStates()) {
    on<GetMyStoreFawaterEventStart>((event, emit) async {
      emit(GetMyStoreFawaterStateStart());

      CustomResponse response = await getMyStoreFawaterData(
        event.storeId,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        GetAllInvoicesModel getAllInvoicesModel =
            GetAllInvoicesModel.fromJson(response.response!.data);
        if (getAllInvoicesModel.status == 200) {
          emit(GetMyStoreFawaterStateSuccess(
              invoicesModel: getAllInvoicesModel));
        } else {
          emit(GetMyStoreFawaterStateFailed(
            msg: getAllInvoicesModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(GetMyStoreFawaterStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetMyStoreFawaterStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(GetMyStoreFawaterStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(GetMyStoreFawaterStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> getMyStoreFawaterData(String storeID) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
// withoutHeader: true,
      headers: headers,
      url: 'get_all_invoices_stor?user_id=28&store_id=$storeID',
    );
    return response;
  }
}
