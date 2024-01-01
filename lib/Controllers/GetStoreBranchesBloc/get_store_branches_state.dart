import 'package:fawatery_user/Models/StroreBranchesModel/store_branches_model.dart';

class GetStoreBranchesStates {}

final class GetStoreBranchesStateStart extends GetStoreBranchesStates {}

final class GetStoreBranchesStateSuccess extends GetStoreBranchesStates {
  final StoreBranchesModel storeBranchesModel;

  GetStoreBranchesStateSuccess({required this.storeBranchesModel});
}

final class GetStoreBranchesStateFailed extends GetStoreBranchesStates {
    final int? errType;
  final String msg;
  final String? field;

  GetStoreBranchesStateFailed({ this.errType, required this.msg,  this.field});

}
