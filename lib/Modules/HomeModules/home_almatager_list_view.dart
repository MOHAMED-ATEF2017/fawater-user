import 'package:fawatery_user/Controllers/HomeBloc/home_bloc.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_event.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:fawatery_user/Shared/Components/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import 'home_almtager_list_view_container.dart';

class HomeAlmatagerListView extends StatelessWidget {
  const HomeAlmatagerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = kiwi.KiwiContainer().resolve<HomeBloc>();
    homeBloc.add(HomeEventAlmatagerStart());
    return SizedBox(
      height: 250.h,
      child: BlocBuilder(
        bloc: homeBloc,
        builder: (context, state) {
          return state is HomeStateMatagerStart
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : state is HomeStateMatagerSuccess
                  ? ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.allStoresModel.data.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return 12.horizontalSpace;
                      },
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 225.w,
                          // height: 174.h,
                          padding: EdgeInsets.all(8.w),
                          margin: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.15),
                                  blurRadius: 2.r,
                                )
                              ]),
                          child: HomeAlmtagerListViewContainer(
                              datum: state.allStoresModel.data[index]),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "There are ERRORS , Please try again later",
                        style: textStyle(),
                      ),
                    );
        },
      ),
    );
  }
}
