import 'package:fawatery_user/Controllers/LogoutBloc/logout_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Screens/AuthScreens/LoginScreen/login_screen.dart';
import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/functions/navigate_fadin.dart';
import '../../Shared/globals.dart';

part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvents, LogoutState> {
  ServerGate serverGate = ServerGate.i;
  LogoutBloc() : super(LogoutState()) {
    on<LogoutEvents>((event, emit) async {
      CustomNavigation.fadeInGetOffAllNavigateFunction(const LoginScreen());

      sendLogoutData().then(
        (value) => InitStorage.deleteAll(),
      );
    });
  }
  Future<CustomResponse> sendLogoutData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
      headers: headers,
      body: null,
      url: 'logout',
    );
    return response;
  }
}
