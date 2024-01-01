class GetMyStoreFawaterEvent {}

class GetMyStoreFawaterEventStart extends GetMyStoreFawaterEvent {
  final String storeId;

  GetMyStoreFawaterEventStart({required this.storeId});
}
