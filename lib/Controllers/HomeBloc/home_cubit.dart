import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeStates());

  // void onIndexTapped(int index) {
  //   emit(HomeStateSelectedIndex(selectedIndex: index));
  // }
  String radioValueId = '';
  void changeGroupValue(String value , String id) {
    radioValueId = id;
    emit(HomeStateChangeGroupValue(groupValue: value));
  }
}
