import 'package:fawatery_user/Controllers/AddRemoveFavoriteBloc/add_remove_favorite_collect_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'add_remove_favorite_event.dart';
import 'add_remove_favorite_state.dart';

class AddRemoveFavoriteBloc
    extends Bloc<AddRemoveFavoriteEvent, AddRemoveFavoriteStates> {
  ServerGate serverGate = ServerGate.i;
  AddRemoveFavoriteBloc() : super(AddRemoveFavoriteStates()) {
    on<AddRemoveFavoriteEventStart>((event, emit) async {
      emit(AddRemoveFavoriteStateStart());

      CustomResponse response = await sendAddRemoveFavoriteData(
        collectData: event.addRemoveFavoriteCollectDate,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        if (response.response!.data['status'] == 200) {
          emit(AddRemoveFavoriteStateSuccess());
        } else {
          emit(AddRemoveFavoriteStateFailed(
            msg: response.response!.data.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(AddRemoveFavoriteStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(AddRemoveFavoriteStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(AddRemoveFavoriteStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(AddRemoveFavoriteStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendAddRemoveFavoriteData({
    required AddRemoveFavoriteCollectDate collectData,
  }) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'add_purchase_invoices_favorite',
        body: collectData.toJson());
    return response;
  }
}
