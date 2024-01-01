import 'package:fawatery_user/Controllers/HomeBloc/home_bloc.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_event.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:fawatery_user/gen/assets.gen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart' as kiwi;

import '../../Modules/AllMatagerModules/matgar_gridview_widget.dart';
import '../../Shared/Components/container_decoration.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/constant_strings.dart';

class AllMatagerScreen extends StatefulWidget {
  const AllMatagerScreen({super.key});

  @override
  State<AllMatagerScreen> createState() => _AllMatagerScreenState();
}

final HomeBloc allStoreBloc = kiwi.KiwiContainer().resolve<HomeBloc>();

class _AllMatagerScreenState extends State<AllMatagerScreen> {
  @override
  void initState() {
    super.initState();
    allStoreBloc.add(HomeEventAlmatagerStart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.almatager),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  Expanded(
                      child: SizedBox(
                          height: 40.h,
                          child: CupertinoSearchTextField(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.r),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.15),
                                    blurRadius: 2.r)
                              ],
                            ),
                            onChanged: (p0) {
                              allStoreBloc
                                  .add(HomeEventSearchStoreStart(name: p0));
                            },
                          ))),
                  20.horizontalSpace,
                  Container(
                    decoration: customContainerBoxDecoration(radius: 4),
                    width: 40.w,
                    height: 40.h,
                    child: Image.asset(Assets.images.filterSearch.path),
                  )
                ],
              ),
            ),
          ),
          16.verticalSpace,
          BlocBuilder(
            bloc: allStoreBloc,
            builder: (context, state) {
              return state is HomeStateMatagerStart
                  ? const Expanded(
                      child: Center(
                        child: CupertinoActivityIndicator(),
                      ),
                    )
                  : state is HomeStateMatagerSuccess
                      ? MatagerGridViewWidget(data: state.allStoresModel.data)
                      : state is HomeStateSearchMatagerSuccess
                          ? MatagerGridViewWidget(
                              data: state.allStoresModel.data)
                          : Center(
                              child: Text(
                                "There are some ERRORS, Please try again later",
                                style: textStyle(),
                              ),
                            );
            },
          ),
        ],
      ),
    );
  }
}
