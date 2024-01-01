import 'package:fawatery_user/Controllers/ChangePasswordBloc/change_password_collect_data.dart';
import 'package:fawatery_user/Screens/AuthScreens/LoginScreen/login_screen.dart';
import 'package:fawatery_user/Shared/API/header.dart';
import 'package:fawatery_user/Shared/API/server_gate.dart';
import 'package:fawatery_user/Shared/functions/navigate_fadin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'change_password_event.dart';
import 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordStates> {
  ServerGate serverGate = ServerGate.i;
  ChangePasswordBloc() : super(ChangePasswordStates()) {
    on<ChangePasswordEventStart>((event, emit) async {
      emit(ChangePasswordStateStart());

      CustomResponse response = await sendChangePasswordData(
        collectData: event.changePasswordCollectData,
      );

      logger.d(
        response.response!.data['status'],
      );
      if (response.statusCode == 200) {
        if (response.response!.data['status'] == 200) {
          emit(ChangePasswordStateSuccess());
          Get.snackbar('SUCCESS', response.response!.data['message']);
        } else if (response.response!.data['status'] == 401) {
          Get.snackbar('ERROR', response.response!.data['message']);
          CustomNavigation.fadeInGetOffAllNavigateFunction(const LoginScreen());
        } else {
          Get.snackbar('ERROR', response.response!.data['message']);

          emit(ChangePasswordStateFailed(
            msg: response.response!.data['message'],
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(ChangePasswordStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          Get.snackbar('ERROR', response.response!.data['message']);

          emit(ChangePasswordStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          Get.snackbar('ERROR', response.response!.data['message']);

          emit(ChangePasswordStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          Get.snackbar('ERROR', response.response!.data['message']);

          emit(ChangePasswordStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendChangePasswordData(
      {required ChangePasswordCollectData collectData}) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'change_password',
        body: collectData.toJson());
    return response;
  }
}
