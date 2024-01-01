class GetStoreBranchesEvent {}

class GetStoreBranchesEventStart extends GetStoreBranchesEvent {
  final String storeId;

  GetStoreBranchesEventStart({required this.storeId});
}
