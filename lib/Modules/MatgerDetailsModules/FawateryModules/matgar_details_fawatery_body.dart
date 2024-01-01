import 'package:fawatery_user/Controllers/GetMyStoreFawaterBloc/get_my_fawater_event.dart';
import 'package:fawatery_user/Controllers/GetMyStoreFawaterBloc/get_my_fawater_state.dart';
import 'package:fawatery_user/Shared/Components/text_style.dart';
import 'package:fawatery_user/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/GetMyStoreFawaterBloc/get_my_fawater_bloc.dart';
import '../../CreateFatoraModules/MyFawaterModules/my_fawatery_list_view_container.dart';

class MatgarDetailsFawateryBody extends StatelessWidget {
  const MatgarDetailsFawateryBody({
    super.key,
    required this.storeId,
  });
  final String storeId;
  @override
  Widget build(BuildContext context) {
    final GetMyStoreFawaterBloc getMyStoreFawaterBloc =
        KiwiContainer().resolve<GetMyStoreFawaterBloc>();

    getMyStoreFawaterBloc.add(GetMyStoreFawaterEventStart(storeId: storeId));
    return BlocBuilder(
      bloc: getMyStoreFawaterBloc,
      builder: (context, state) {
        return state is GetMyStoreFawaterStateStart
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : state is GetMyStoreFawaterStateSuccess
                ? Column(
                    children: [
                      12.verticalSpace,
                      //******************* search and filter ******************* */
                      Row(
                        children: [
                          17.horizontalSpace,
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
                                    prefixIcon:
                                        Assets.images.receiptSearch.image(),
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
                          ),
                          17.horizontalSpace,
                        ],
                      ),
                      16.verticalSpace,
                      Expanded(
                        child: ListView.separated(
                          padding: EdgeInsets.symmetric(
                              horizontal: 17.w, vertical: 17.h),
                          itemCount: state.invoicesModel.data.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return 12.verticalSpace;
                          },
                          itemBuilder: (BuildContext context, int index) {
                            var data = state.invoicesModel.data[index];
                            return FawateryListViewContainer(datum: data);
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'There are some ERRORS , please try again later',
                      style: textStyle(),
                    ),
                  );
      },
    );
  }
}
