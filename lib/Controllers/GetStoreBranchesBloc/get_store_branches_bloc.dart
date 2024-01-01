import 'package:fawatery_user/Models/StroreBranchesModel/store_branches_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'get_store_branches_event.dart';
import 'get_store_branches_state.dart';

class StoreBranchesBloc
    extends Bloc<GetStoreBranchesEvent, GetStoreBranchesStates> {
  ServerGate serverGate = ServerGate.i;
  StoreBranchesBloc() : super(GetStoreBranchesStates()) {
    on<GetStoreBranchesEventStart>((event, emit) async {
      emit(GetStoreBranchesStateStart());

      CustomResponse response = await sendGetStoreBranchesData(
        storeId: event.storeId,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        StoreBranchesModel storeBranchesModel =
            StoreBranchesModel.fromJson(response.response!.data);
        if (storeBranchesModel.status == 200) {
          emit(GetStoreBranchesStateSuccess(
              storeBranchesModel: storeBranchesModel));
        } else {
          emit(GetStoreBranchesStateFailed(
            msg: storeBranchesModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(GetStoreBranchesStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetStoreBranchesStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(GetStoreBranchesStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(GetStoreBranchesStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendGetStoreBranchesData({
    required String storeId,
  }) async {
     String? token= await  InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'get_branches',
        body: {'id_store': storeId});
    return response;
  }
}
