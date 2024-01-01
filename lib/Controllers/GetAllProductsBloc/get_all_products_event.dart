final class GetAllProductsEvent {}

final class GetAllProductsEventStart extends GetAllProductsEvent {}

final class GetAllProductsSearchEventStart extends GetAllProductsEvent {
  final String name;

  GetAllProductsSearchEventStart({required this.name});
}
