import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/NotificationModel/notification_model.dart';
import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'notification_event.dart';
import 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationStates> {
  ServerGate serverGate = ServerGate.i;
  NotificationBloc() : super(NotificationStates()) {
    on<NotificationEventStart>((event, emit) async {
      emit(NotificationStateStart());

      CustomResponse response = await getNotificationData();

      logger.d(
        response.statusCode,
      );
      if (response.statusCode == 200) {
        NotificationModel notificationModel =
            NotificationModel.fromJson(response.response!.data);
        if (notificationModel.status == 200) {
          emit(NotificationStateSuccess(notificationModel: notificationModel));
        } else {
          emit(NotificationStateFailed(
            msg: notificationModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(NotificationStateFailed(msg: response.statusMessage.toString()));
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(NotificationStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (response.errType == 1) {
          emit(NotificationStateFailed(
            errType: 1,
            msg: response.msg,
// field: response.error['field']
          ));
        } else {
          emit(NotificationStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

  Future<CustomResponse> getNotificationData() async {
    String? userID =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
// withoutHeader: true,
      headers: headers,
      url: 'get_notifications?user_id=$userID',
    );
    return response;
  }
}
