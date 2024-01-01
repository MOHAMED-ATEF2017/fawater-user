import 'package:fawatery_user/Controllers/RatingBloc/rating_collect_data.dart';
import 'package:fawatery_user/Models/RatingModel/rating_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'rating_event.dart';
import 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingStates> {
  ServerGate serverGate = ServerGate.i;
  RatingBloc() : super(RatingStates()) {
    //**************************** Get Rating **************************** */
    on<GetRatingEventStart>((event, emit) async {
      emit(GetRatingStateStart());

      CustomResponse response = await getRatingData(
        storeId: event.storeId,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        GetRatingsModel getRatingModel =
            GetRatingsModel.fromJson(response.response!.data);
        if (getRatingModel.status == 200) {
          emit(GetRatingStateSuccess(getRatingsModel: getRatingModel));
        } else {
          emit(GetRatingStateFailed(
            msg: getRatingModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(GetRatingStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetRatingStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(GetRatingStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(GetRatingStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });

    //**************************** Add Rating **************************** */
    on<AddRatingEventStart>((event, emit) async {
      emit(AddRatingStateStart());

      CustomResponse response = await postAddRatingData(
          collectData: event.addRatingCollectData, storeId: event.storeId);

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        if (response.response!.data['status'] == 200) {
          emit(AddRatingStateSuccess());
          Get.back();
          Get.forceAppUpdate();
        } else {
          emit(AddRatingStateFailed(
            msg: response.msg,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(AddRatingStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(AddRatingStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(AddRatingStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(AddRatingStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

//************************* Get Rating ********************* */
  Future<CustomResponse> getRatingData({
    required String storeId,
  }) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'get_rating',
        body: {'id_store': storeId});
    return response;
  }

//********************** Post Rating ******************** */
  Future<CustomResponse> postAddRatingData(
      {required AddRatingCollectData collectData,
      required String storeId}) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? userId =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'add_rating',
        body: collectData.toJson(storeId: storeId, userId: userId!));
    return response;
  }
}
