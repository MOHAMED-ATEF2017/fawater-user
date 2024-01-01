import 'package:fawatery_user/Models/NotificationModel/notification_model.dart';

class NotificationStates {}

final class NotificationStateStart extends NotificationStates {}

final class NotificationStateSuccess extends NotificationStates {
  final NotificationModel notificationModel;

  NotificationStateSuccess({required this.notificationModel});
}
final class NotificationStateFailed extends NotificationStates {
 final int? errType;
  final String msg;
  final String? field;

  NotificationStateFailed({ this.errType, required this.msg,  this.field});

}
