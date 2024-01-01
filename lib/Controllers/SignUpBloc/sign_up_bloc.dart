import 'package:fawatery_user/Controllers/SignUpBloc/sign_up_collect_data.dart';
import 'package:fawatery_user/Models/SignUpModel/sign_up_model.dart';
import 'package:fawatery_user/Screens/AuthScreens/LoginScreen/login_screen.dart';
import 'package:fawatery_user/Shared/functions/navigate_fadin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/globals.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpStates> {
  ServerGate serverGate = ServerGate.i;
  SignUpBloc() : super(SignUpStates()) {
    on<SignUpEventStart>((event, emit) async {
      emit(SignUpStateStart());

      CustomResponse response = await sendSignUpData(
        collectData: event.signUpCollectData,
      );

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        SignUpModel signUpModel = SignUpModel.fromJson(response.response!.data);
        if (signUpModel.status == '200') {
// await InitStorage.storage
// .write(key: AppStrings.storageTokenKey, value: signUpModel.token);
          emit(SignUpStateSuccess(signUpModel: signUpModel));
          CustomNavigation.fadeInGetOffAllNavigateFunction(const LoginScreen());
          Get.snackbar('Success', signUpModel.message);
        } else {
          emit(SignUpStateFailed(
            msg: signUpModel.message,
          ));
        }
      } else {
        logger.e(
            'from map event to state show error => error type is ${response.errType}');

        if (response.errType == 0) {
          emit(SignUpStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          Get.snackbar('ERROR', response.msg);

          emit(SignUpStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          Get.snackbar('ERROR', response.msg);

          emit(SignUpStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendSignUpData({
    required SignUpCollectData collectData,
  }) async {
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
        headers: headers,
        url: 'register',
        body: collectData.toJson());
    return response;
  }
}
