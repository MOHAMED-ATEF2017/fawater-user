import 'package:fawatery_user/Models/GetProfileModel/get_profile_model.dart';
import 'package:fawatery_user/Screens/AuthScreens/LoginScreen/login_screen.dart';
import 'package:fawatery_user/Shared/functions/navigate_fadin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileStates> {
  ServerGate serverGate = ServerGate.i;

  GetProfileBloc() : super(GetProfileStates()) {
    on<GetProfileEvent>((event, emit) async {
      emit(GetProfileStateStart());

      CustomResponse response = await sendGetProfileData();
      if (response.statusCode == 200) {
        GetProfileModel getProfileModel =
            GetProfileModel.fromJson(response.response!.data);
        if (getProfileModel.status == 200) {
          await InitStorage.storage.write(key: AppStrings.storageUserImageKey, value: getProfileModel.data.first.img);
          emit(GetProfileStateSuccess(getProfileModel: getProfileModel));
        } else {
          emit(GetProfileStateFailed(
            msg: getProfileModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
        // emit(LoginStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetProfileStateFailed(
            errType: 0,
            msg: 'Network error ',

            // msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(GetProfileStateFailed(
            errType: 1,
            msg: response.msg,
            // field: response.error['field']
          ));
        } else {
          CustomNavigation.fadeInGetOffAllNavigateFunction(const LoginScreen());
          Get.snackbar('WARNING', response.msg);
          emit(GetProfileStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
            // field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendGetProfileData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
        // withoutHeader: true,
        headers: headers,
        url: 'get_user',
        body: {'token': token});
    return response;
  }
}
