import 'package:fawatery_user/Models/GetFavoritesModel/get_favorite_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'get_favorites_event.dart';
import 'get_favorites_state.dart';

class GetFavoritesBloc extends Bloc<GetFavoritesEvent, GetFavoritesStates> {
  ServerGate serverGate = ServerGate.i;
  GetFavoritesBloc() : super(GetFavoritesStates()) {
    on<GetFavoritesEventStart>((event, emit) async {
      emit(GetFavoritesStateStart());

      CustomResponse response = await getGetFavoritesData();

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        GetFavoritesModel getFavoritesModel =
            GetFavoritesModel.fromJson(response.response!.data);
        if (getFavoritesModel.status == 200) {
          emit(GetFavoritesStateSuccess(getFavoritesModel: getFavoritesModel));
        } else {
          emit(GetFavoritesStateFailed(
            msg: getFavoritesModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(GetFavoritesStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetFavoritesStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(GetFavoritesStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(GetFavoritesStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> getGetFavoritesData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? userId =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);

    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
// withoutHeader: true,
      headers: headers,
      url: 'get_purchase_invoices_favorite?user_id=$userId',
    );
    return response;
  }
}
