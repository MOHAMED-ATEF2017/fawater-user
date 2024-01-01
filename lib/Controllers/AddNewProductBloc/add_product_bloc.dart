import 'package:fawatery_user/Controllers/AddNewProductBloc/add_product_collect_data.dart';
import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_bloc.dart';
import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kiwi/kiwi.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'add_product_event.dart';
import 'add_product_state.dart';

class AddNewProductBloc extends Bloc<AddProductEvent, AddProductStates> {
  ServerGate serverGate = ServerGate.i;
  final GetAllProductsBloc getAllProductsBloc =
      KiwiContainer().resolve<GetAllProductsBloc>();
  AddNewProductBloc() : super(AddProductStates()) {
    on<AddProductEventStart>((event, emit) async {
      emit(AddProductStateStart());

      CustomResponse response = await sendAddNewProductData(
        collectData: event.addNewProductCollectData,
      );
      if (response.statusCode == 200) {
        if (response.response!.data['status'] == 200) {
          getAllProductsBloc.add(GetAllProductsEventStart());
          Get.back();
          emit(AddProductStateSuccess());
                    Get.forceAppUpdate();

        } else {
          emit(AddProductStateFailed(
            msg: response.msg,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(AddProductStateFailed(
            errType: 0,
            msg: 'Network error ',
          ));
        } else if (response.errType == 1) {
          emit(AddProductStateFailed(
            errType: 1,
            msg: response.msg,
          ));
        } else {
          emit(AddProductStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
          ));
        }
      }
    });
  }

  Future<CustomResponse> sendAddNewProductData(
      {required AddNewProductCollectData collectData}) async {
    String? userId =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
        headers: headers,
        url: 'create_products',
        body: collectData.toJson(userId!));
    return response;
  }
}
