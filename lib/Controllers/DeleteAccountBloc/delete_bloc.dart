import 'package:fawatery_user/Controllers/DeleteAccountBloc/delete_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';

part 'delete_state.dart';

class DeleteAccountBloc extends Bloc<DeleteAccountEvents, DeleteAccountState> {
  ServerGate serverGate = ServerGate.i;
  DeleteAccountBloc() : super(DeleteAccountState()) {
    on<DeleteAccountEventStart>((event, emit) async {
      CustomResponse response = await sendDeleteAccountData();

      if (response.statusCode == 200) {
        emit(DeleteAccountStateSuccess());
      } else {
        logger.e('from map event to state show error => ');
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(DeleteAccountStateFailed(
            errType: 0,
            msg: 'Network error ',
          ));
        } else if (response.errType == 1) {
          emit(DeleteAccountStateFailed(
            errType: 1,
            msg: response.msg,
          ));
        } else {
          emit(DeleteAccountStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
          ));
        }
      }
    });
  }
  Future<CustomResponse> sendDeleteAccountData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? userId =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
      headers: headers,
      body: {"user_id": userId},
      url: 'delete_account',
    );
    return response;
  }
}
