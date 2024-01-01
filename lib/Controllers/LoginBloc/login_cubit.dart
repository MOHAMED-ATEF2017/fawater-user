import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginStates());

  void loginWithEmail() {
    emit(LoginWithEmailState());
  }

  void loginWithPhone() {
    emit(LoginWithPhoneState());
  }
}
