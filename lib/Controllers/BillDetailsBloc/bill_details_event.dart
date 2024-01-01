class BillDetailsEvent {}

class BillDetailsEventStart extends BillDetailsEvent {
  final String id;

  BillDetailsEventStart({required this.id});
}
