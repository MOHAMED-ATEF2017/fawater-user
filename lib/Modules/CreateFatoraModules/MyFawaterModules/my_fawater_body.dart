import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:fawatery_user/Shared/Components/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/HomeBloc/home_bloc.dart';
import '../../../Controllers/HomeBloc/home_event.dart';
import '../../../gen/assets.gen.dart';
import 'my_fawatery_list_view_container.dart';

class MyFawaterBody extends StatelessWidget {
  const MyFawaterBody({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = KiwiContainer().resolve<HomeBloc>();

    homeBloc.add(HomeEventInvoicesStart());

    return BlocBuilder(
      bloc: homeBloc,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 17.h),
          child: Column(
            children: [
              //******************* search and filter ******************* */
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(.15),
                                blurRadius: 2.r)
                          ]),
                      child: TextFormField(
                        enableInteractiveSelection: false,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsetsDirectional.only(
                              start: 5.w,
                              top: 5.h,
                            ),
                            prefixIcon: Assets.images.receiptSearch.image(),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                  12.horizontalSpace,
                  Container(
                    width: 44.w,
                    height: 44.h,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(.15),
                              blurRadius: 2.r)
                        ]),
                    child: Assets.images.filterSearch.image(),
                  )
                ],
              ),
              16.verticalSpace,
              //******************** list view of fawater ***************** */
              Expanded(
                child: state is HomeStateInvoicesStart
                    ? const CupertinoActivityIndicator()
                    : state is HomeStateInvoicesSuccess?
                  state.getAllInvoicesModel.data.isEmpty?
                  
                  Center(
                    child: Text("There aren't any invoice", style: textStyle(),),
                  )
                  :
                     ListView.separated(
                        padding: EdgeInsets.only(bottom: 26.h),
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.getAllInvoicesModel.data.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return 12.verticalSpace;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var data = state.getAllInvoicesModel.data[index];
                          return  FawateryListViewContainer(datum: data,);
                        },
                      ):Center(
                        child: Text('There are ERRORS, Please try again later' , style: textStyle(),),
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
