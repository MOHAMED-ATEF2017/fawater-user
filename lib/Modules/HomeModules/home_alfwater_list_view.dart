import 'package:fawatery_user/Controllers/HomeBloc/home_bloc.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_event.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:fawatery_user/Shared/Components/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import 'home_alfwater_list_view_container.dart';

class HomeAlfwaterListView extends StatelessWidget {
  const HomeAlfwaterListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = KiwiContainer().resolve<HomeBloc>();

    homeBloc.add(HomeEventInvoicesStart());

    return SizedBox(
      height: 250.h,
      child: BlocBuilder(
          bloc: homeBloc,
          builder: (context, state) {
            return state is HomeStateInvoicesStart
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : state is HomeStateInvoicesSuccess
                    ? state.getAllInvoicesModel.data.isEmpty
                        ? Center(
                            child: Text(
                              "There aren't any invoice available yet",
                              style: textStyle(),
                            ),
                          )
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.getAllInvoicesModel.data.length,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return 12.horizontalSpace;
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var data = state.getAllInvoicesModel.data[index];
                              return Container(
                                width: 225.w,
                                // height: 174.h,
                                padding: EdgeInsets.all(12.w),
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
                                child:  HomeAlFwaterListViewContainer(datum:data , homeBloc:homeBloc , index: index,),
                              );
                            },
                          )
                    : Center(
                        child: Text(
                          "There are ERRORS, Please try again later",
                          style: textStyle(),
                        ),
                      );
          }),
    );
  }
}
