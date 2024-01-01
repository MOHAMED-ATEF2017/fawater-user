import 'package:fawatery_user/Models/GetAllInvoices/get_all_invoices_model.dart';
import 'package:fawatery_user/Models/HomeModel/home_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Models/AllStoresModel/all_stores_model.dart';
import '../../Shared/API/header.dart';
import '../../Shared/API/server_gate.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../Shared/globals.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvents, HomeStates> {
  ServerGate serverGate = ServerGate.i;
  List<bool> isLocalFavorite = [];
  HomeBloc() : super(HomeStates()) {
    late AllStoresModel allStoresModel;
    //********************** invoices response ****************** */
    on<HomeEventInvoicesStart>((event, emit) async {
      emit(HomeStateInvoicesStart());
      CustomResponse invoicesResponse = await getAllInvoicesData();

      if (invoicesResponse.statusCode == 200) {
        GetAllInvoicesModel getAllInvoicesModel =
            GetAllInvoicesModel.fromJson(invoicesResponse.response!.data);
        if (getAllInvoicesModel.status == 200) {
          isLocalFavorite =
              List.generate(getAllInvoicesModel.data.length, (index) => false);
          for (int i = 0; i < getAllInvoicesModel.data.length; i++) {
            isLocalFavorite[i] = getAllInvoicesModel.data[i].favorite;
          }
          emit(HomeStateInvoicesSuccess(
              getAllInvoicesModel: getAllInvoicesModel));
        } else {
          emit(HomeStateFailed(
            msg: getAllInvoicesModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(HomeStateFailed(msg: response.statusMessage.toString()));
        logger.e(invoicesResponse.errType.toString());

        if (invoicesResponse.errType == 0) {
          emit(HomeStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (invoicesResponse.errType == 1) {
          emit(HomeStateFailed(
            errType: 1,
            msg: invoicesResponse.msg,
// field: response.error['field']
          ));
        } else {
          emit(HomeStateFailed(
            errType: 2,
            msg:
                invoicesResponse.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });

    //****************** matager response ************** */
    on<HomeEventAlmatagerStart>((event, emit) async {
      emit(HomeStateMatagerStart());

      CustomResponse matagerResponse = await getAllStoresData();
      if (matagerResponse.statusCode == 200) {
        allStoresModel =
            AllStoresModel.fromJson(matagerResponse.response!.data);
        if (allStoresModel.status == 200) {
          emit(HomeStateMatagerSuccess(allStoresModel: allStoresModel));
        } else {
          emit(HomeStateFailed(
            msg: allStoresModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(HomeStateFailed(msg: response.statusMessage.toString()));
        logger.e(matagerResponse.errType.toString());

        if (matagerResponse.errType == 0) {
          emit(HomeStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (matagerResponse.errType == 1) {
          emit(HomeStateFailed(
            errType: 1,
            msg: matagerResponse.msg,
// field: response.error['field']
          ));
        } else {
          emit(HomeStateFailed(
            errType: 2,
            msg: matagerResponse.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });

    //****************** search matager response ************** */
    on<HomeEventSearchStoreStart>((event, emit) async {
      emit(HomeStateMatagerStart());

      CustomResponse matagerResponse = await postSearchStoresData(event.name);
      if (matagerResponse.statusCode == 200) {
        allStoresModel =
            AllStoresModel.fromJson(matagerResponse.response!.data);
        if (allStoresModel.status == 200) {
          emit(HomeStateSearchMatagerSuccess(allStoresModel: allStoresModel));
        } else {
          emit(HomeStateFailed(
            msg: allStoresModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(HomeStateFailed(msg: response.statusMessage.toString()));
        logger.e(matagerResponse.errType.toString());

        if (matagerResponse.errType == 0) {
          emit(HomeStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (matagerResponse.errType == 1) {
          emit(HomeStateFailed(
            errType: 1,
            msg: matagerResponse.msg,
// field: response.error['field']
          ));
        } else {
          emit(HomeStateFailed(
            errType: 2,
            msg: matagerResponse.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });

    //****************** HomeData response ************** */
    on<HomeEventDataStart>((event, emit) async {
      emit(HomeStateGetDataStart());

      CustomResponse matagerResponse = await getHomeData();
      if (matagerResponse.statusCode == 200) {
        HomeModel homeModel =
            HomeModel.fromJson(matagerResponse.response!.data);
        if (homeModel.status == 200) {
          emit(HomeStateGetDataSuccess(homeModel: homeModel));
        } else {
          emit(HomeStateFailed(
            msg: homeModel.message,
          ));
        }
      } else {
        logger.e('from map event to state show error => ');
// emit(HomeStateFailed(msg: response.statusMessage.toString()));
        logger.e(matagerResponse.errType.toString());

        if (matagerResponse.errType == 0) {
          emit(HomeStateFailed(
            errType: 0,
            msg: 'Network error ',

// msg: response.error.toString(),
          ));
        } else if (matagerResponse.errType == 1) {
          emit(HomeStateFailed(
            errType: 1,
            msg: matagerResponse.msg,
// field: response.error['field']
          ));
        } else {
          emit(HomeStateFailed(
            errType: 2,
            msg: matagerResponse.msg /* ?? 'Server error , please try again' */,
// field: response.error['field']
          ));
        }
      }
    });
  }

//************* get stores ***************** */
  Future<CustomResponse> getAllStoresData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
      headers: headers,
      url: 'get_all_stores',
    );
    return response;
  }

//************* get search stores ***************** */
  Future<CustomResponse> postSearchStoresData(String name) async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.sendToServer(
      headers: headers,
      body: {'name': name},
      url: 'search_for_store',
    );
    return response;
  }

//************* get data ***************** */
  Future<CustomResponse> getHomeData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? userID =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
      headers: headers,
      url: 'get_info_home_screen?user_id=$userID',
    );
    return response;
  }

  //************* get invoices ***************** */
  Future<CustomResponse> getAllInvoicesData() async {
    String? token =
        await InitStorage.storage.read(key: AppStrings.storageTokenKey);
    String? userId =
        await InitStorage.storage.read(key: AppStrings.storageUserIdKey);
    Map<String, dynamic> headers = await headersMap(token!);
    CustomResponse response = await serverGate.getFromServer(
      headers: headers,
      url: 'get_all_invoices?user_id=$userId',
    );
    return response;
  }
}
