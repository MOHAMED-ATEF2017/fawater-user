import 'package:fawatery_user/Controllers/UpdateProfilebloc/update_profile_state.dart';
import 'package:fawatery_user/Models/GetProfileModel/get_profile_model.dart';
import 'package:fawatery_user/Shared/API/header.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import '../GetProfileBloc/get_profile_collect_data.dart';
import 'update_profile_event.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileStates> {
  ServerGate serverGate = ServerGate.i;

  UpdateProfileBloc() : super(UpdateProfileStates()) {
    on<UpdateProfileEventStart>((event, emit) async {
      emit(UpdateProfileStateStart());

      CustomResponse response = await sendUpdateProfileData(
        collectData: event.updateProfileCollectData,
      );

      if (response.statusCode == 200) {
        GetProfileModel updateProfileModel =
            GetProfileModel.fromJson(response.response!.data);
        if (updateProfileModel.status == 200) {
          emit(UpdateProfileStateSuccess(
              updateProfileModel: updateProfileModel));
          Get.snackbar("SUCCESS", 'Update Successfuly');
        } else {
          emit(UpdateProfileStateFailed(
            msg: updateProfileModel.message,
          ));
          Get.snackbar("ERROR", updateProfileModel.message);
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(UpdateProfileStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(UpdateProfileStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
          Get.snackbar("ERROR", response.msg);
        } else if (response.errType == 1) {
          emit(UpdateProfileStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
          Get.snackbar("ERROR", response.msg);
        } else {
          emit(UpdateProfileStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
          Get.snackbar("ERROR", response.msg);
        }
      }
    });
  }

  Future<CustomResponse> sendUpdateProfileData({
    required UpdateProfileCollectData collectData,
  }) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'Edit_profile',
        body: collectData.mapToJson());
    return response;
  }
}
