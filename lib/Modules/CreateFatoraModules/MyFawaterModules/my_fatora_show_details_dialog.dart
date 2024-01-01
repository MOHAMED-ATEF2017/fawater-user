import 'package:fawatery_user/Controllers/BillDetailsBloc/bill_details_event.dart';
import 'package:fawatery_user/Controllers/BillDetailsBloc/bill_details_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/BillDetailsBloc/bill_details_bloc.dart';
import '../../../Shared/Components/container_decoration.dart';
import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import 'byanat_almatgar_tab_body.dart';
import 'byanat_almontag_tab_body.dart';
import 'byanat_almostaghdem_tab_body.dart';

class MyFatoraShowDetailsDialog extends StatelessWidget {
  const MyFatoraShowDetailsDialog({
    super.key,
    required this.id,
  });
  final String id;
  @override
  Widget build(BuildContext context) {
    final BillDetailsBloc billDetailsBloc =
        KiwiContainer().resolve<BillDetailsBloc>();
    billDetailsBloc.add(BillDetailsEventStart(id: id));
    return Material(
      color: Colors.transparent,
      child: BlocBuilder(
        bloc: billDetailsBloc,
        builder: (context, state) {
          return state is BillDetailsStateStart
              ? const Center(
                  child: CupertinoActivityIndicator(),
                )
              : state is BillDetailsStateSuccess
                  ? Container(
                      margin: EdgeInsets.symmetric(
                          vertical: (1.sh - 495.h/* 610.h */) / 2,
                          horizontal: (1.sw - 343.w) / 2),
                      padding: EdgeInsets.symmetric(
                          vertical: 24.h, horizontal: 12.w),
                      decoration: customContainerBoxDecoration(),
                      child: DefaultTabController(
                          length: 3,
                          child: Column(
                            children: [
                              TabBar(
                                  labelStyle: textStyle(
                                      color: AppColors.ffF05A27OrangeColor,
                                      size: 12),
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: EdgeInsets.symmetric(
                                    horizontal: 35.w,
                                  ),
                                  overlayColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  indicatorWeight: 4,
                                  dividerColor: Colors.transparent,
                                  unselectedLabelColor: AppColors.ffC1C2C3Icons,
                                  labelColor: AppColors.ffF05A27OrangeColor,
                                  indicatorColor: AppColors.ffF05A27OrangeColor,
                                  labelPadding: EdgeInsets.only(bottom: 10.h),
                                  tabs: const [
                                    Text(AppStrings.matgarInformation),
                                    Text(AppStrings.mostaghdamInformation),
                                    Text(AppStrings.montagatInformation),
                                  ]),
                              Expanded(
                                  child: TabBarView(children: [
                                ByanatALmatgarTabBody(
                                    billDetailsModel:
                                        state.billDetailsModel,
                                        id:id
                                   ),
                                ByanatALmostaghdemTabBody(
                              billDetailsModel:    state.billDetailsModel,
                                    index: 0,id:id),
                                ByanatAlmontagTabBody(
                                billDetailsModel: state.billDetailsModel,id:id),
                              ])),
                            ],
                          )),
                    )
                  : Center(
                      child: Text(
                        'There are some  ERRORS , please try again later',
                        style: textStyle(),
                      ),
                    );
        },
      ),
    );
  }
}
