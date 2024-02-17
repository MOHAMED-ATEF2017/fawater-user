part of 'delete_bloc.dart';

class DeleteAccountState {}

class DeleteAccountStateStart extends DeleteAccountState {}
class DeleteAccountStateSuccess extends DeleteAccountState {}
class DeleteAccountStateFailed extends DeleteAccountState {
    final int? errType;
  final String msg;
  final String? field;

  DeleteAccountStateFailed({this.errType, required this.msg, this.field});

}
