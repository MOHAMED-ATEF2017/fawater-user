import 'package:fawatery_user/Screens/MainScreen/main_screen.dart';
import 'package:fawatery_user/Shared/functions/navigate_fadin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/LoginModel/login_model.dart';
import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'login_collect_data.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStates> {
  ServerGate serverGate = ServerGate.i;
  LoginBloc() : super(LoginStates()) {
    on<LoginEventStart>((event, emit) async {
      emit(LoginStateStart());

      CustomResponse response = await sendLoginData(
          collectData: event.loginCollectData,
          isPhoneLogin: event.isPhoneLogin);

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        LoginModel loginModel = LoginModel.fromJson(response.response!.data);
        if (loginModel.success == true) {
          Future.wait([
            InitStorage.storage.write(
                key: AppStrings.storageTokenKey, value: loginModel.token),
            InitStorage.storage.write(
                key: AppStrings.storageUserIdKey,
                value: loginModel.userId.toString()),
          ]);
          emit(LoginStateSuccess(loginModel: loginModel));
          CustomNavigation.fadeInGetOffAllNavigateFunction(const MainScreen());
        } else {
          emit(LoginStateFailed(
            msg: loginModel.message,
          ));
        }
      } else {
        logger.e("from map event to state show error => ");
        // emit(LoginStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(LoginStateFailed(
            errType: 0,
            msg: "Network error ",

            // msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(LoginStateFailed(
            errType: 1,
            msg: response.msg,
            // field: response.error['field']
          ));
        } else {
          emit(LoginStateFailed(
            errType: 2,
            msg: response.msg /* ?? "Server error , please try again" */,
            // field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendLoginData(
      {required LoginCollectData collectData,
      required bool isPhoneLogin}) async {
    logger.d(isPhoneLogin ? "login_by_phone" : "login_by_email");
    Map<String, dynamic> headers = await headersMapWithoutToken();
    CustomResponse response = await serverGate.sendToServer(
        // withoutHeader: true,
        headers: headers,
        url: isPhoneLogin ? "login_by_phone" : "login_by_email",
        body: isPhoneLogin
            ? collectData.phoneToJson()
            : collectData.emailToJson());
    return response;
  }
}
