import 'package:fawatery_user/Controllers/AddNewProductBloc/add_product_collect_data.dart';

class AddProductEvent {}

class AddProductEventStart extends AddProductEvent {
  final AddNewProductCollectData addNewProductCollectData;

  AddProductEventStart({required this.addNewProductCollectData});
}
