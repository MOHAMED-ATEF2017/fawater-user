import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetAllProductsCubit extends Cubit<GetAllProductsState> {
  GetAllProductsCubit() : super(GetAllProductsState());
  List<Map<String, dynamic>> selectedProduct = [];

  void changeGroupValue(String value) {
    emit(GetAllStateChangeGroupValue(groubValue: value));
  }

  void changeSelectedProduct(int index) {
    selectedProduct[index]
        .update('Quantity', (value) => selectedProduct[index]["Quantity"] + 1);
  }
}
