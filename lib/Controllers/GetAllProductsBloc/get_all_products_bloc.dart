import 'package:fawatery_user/Models/AllProductsModel/all_products_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'get_all_products_event.dart';
import 'get_all_products_state.dart';

class GetAllProductsBloc
    extends Bloc<GetAllProductsEvent, GetAllProductsState> {
  ServerGate serverGate = ServerGate.i;
  List<bool> checkedBoxValues = [];
 late GetAllProductsModel getAllProductsModel;
  GetAllProductsBloc() : super(GetAllProductsState()) {

    //***************** get allproduct **************** */
    on<GetAllProductsEventStart>((event, emit) async {
      emit(GetAllProductsStateStart());

      CustomResponse response = await getAllProdutsData();

      if (response.statusCode == 200) {
         getAllProductsModel =
            GetAllProductsModel.fromJson(response.response!.data);
        if (getAllProductsModel.status == 200) {
          checkedBoxValues.clear();
          checkedBoxValues =
              List.generate(getAllProductsModel.data.length, (index) => false);
          emit(GetAllProductsStateSuccess(
              getAllProductsModel: getAllProductsModel));
        } else {
          emit(GetAllProductsStateFailed(
            msg: getAllProductsModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetAllProductsStateFailed(
            errType: 0,
            msg: 'Network error ',
          ));
        } else if (response.errType == 1) {
          emit(GetAllProductsStateFailed(
            errType: 1,
            msg: response.msg,
          ));
        } else {
          emit(GetAllProductsStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
          ));
        }
      }
    });
    //***************** get search product **************** */
    on<GetAllProductsSearchEventStart>((event, emit) async {
      emit(GetAllProductsSearchStateStart());

      CustomResponse response = await postSearchProdutsData(event.name);

      if (response.statusCode == 200) {
         getAllProductsModel =
            GetAllProductsModel.fromJson(response.response!.data);
        if (getAllProductsModel.status == 200) {
          checkedBoxValues.clear();
          checkedBoxValues =
              List.generate(getAllProductsModel.data.length, (index) => false);
          emit(GetAllProductsSearchStateSuccess(
              getAllProductsModel: getAllProductsModel));
        } else {
          emit(GetAllProductsStateFailed(
            msg: getAllProductsModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
        logger.e(response.errType.toString());

        if (response.errType == 0) {
          emit(GetAllProductsStateFailed(
            errType: 0,
            msg: 'Network error ',
          ));
        } else if (response.errType == 1) {
          emit(GetAllProductsStateFailed(
            errType: 1,
            msg: response.msg,
          ));
        } else {
          emit(GetAllProductsStateFailed(
            errType: 2,
            msg: response.msg /* ?? 'Server error , please try again' */,
          ));
        }
      }
    });
  
  
  }


//******************* get all product **************** */
  Future<CustomResponse> getAllProdutsData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
// withoutHeader: true,
      headers: headers,
      url: 'get_all_products',
    );
    return response;
  }

//******************* post search product **************** */
  Future<CustomResponse> postSearchProdutsData(String name) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
// withoutHeader: true,
      headers: headers,
      body: {'name':name},
      url: 'search_for_products',
    );
    return response;
  }
}
