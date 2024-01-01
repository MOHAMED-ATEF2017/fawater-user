class HomeEvents {}

class HomeEventAlmatagerStart extends HomeEvents {}

class HomeEventInvoicesStart extends HomeEvents {}

class HomeEventDataStart extends HomeEvents {}

class HomeEventSearchStoreStart extends HomeEvents {
  final String name;

  HomeEventSearchStoreStart({required this.name});
}
