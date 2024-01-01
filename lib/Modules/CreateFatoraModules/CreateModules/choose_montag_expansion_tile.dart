import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_bloc.dart';
import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_cubit.dart';
import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_event.dart';
import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_state.dart';
import 'package:fawatery_user/Models/AllProductsModel/all_products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../Shared/Components/text_style.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import '../../../gen/assets.gen.dart';
import 'add_new_montage_dialog.dart';

class ChooseMontageAtCreateFatoraByDetailsExpansionTile
    extends StatelessWidget {
  const ChooseMontageAtCreateFatoraByDetailsExpansionTile({
    super.key,
    required this.getProductsBloc,
    required this.getAllProductsCubit,
    required this.scrollController,
  });

  final GetAllProductsBloc getProductsBloc;
  final GetAllProductsCubit getAllProductsCubit;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.black.withOpacity(.15))),
        child: ExpansionTile(
          clipBehavior: Clip.antiAlias,
          title: Text(
            AppStrings.chooseMontag,
            style: textStyle(color: AppColors.ffF05A27OrangeColor),
          ),
          collapsedBackgroundColor: AppColors.ffFEEFE9PrimaryLight,
          backgroundColor: AppColors.ffFEEFE9PrimaryLight,
          iconColor: AppColors.ffF05A27OrangeColor,
          collapsedIconColor: AppColors.ffF05A27OrangeColor,
          shape: RoundedRectangleBorder(
              side: BorderSide.none, borderRadius: BorderRadius.circular(12.r)),
          children: [
            CupertinoSearchTextField(
              backgroundColor: Colors.white,
              onChanged: (p0) {
                getProductsBloc.add(GetAllProductsSearchEventStart(name: p0));
              },
            ),
            InkWell(
              onTap: () {
                Get.dialog(AddNewMontageDialogContainer());
              },
              child: Container(
                color: Colors.white,
                height: 40.h,
                child: Row(
                  children: [
                    8.horizontalSpace,
                    Assets.icons.addSquare.svg(),
                    8.horizontalSpace,
                    Text(
                      AppStrings.addNewMontag,
                      style:
                          textStyle(size: 12, color: AppColors.ffC1C2C3Icons),
                    )
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              height: 146.h,
              child: BlocBuilder(
                bloc: getProductsBloc,
                builder: (context, state) {
                  return state is GetAllProductsStateStart
                      ? const CupertinoActivityIndicator()
                      : state is GetAllProductsSearchStateStart
                          ? const CupertinoActivityIndicator()
                          : state is GetAllProductsStateSuccess
                              ? succesProductsList(state.getAllProductsModel)
                              : state is GetAllProductsSearchStateSuccess
                                  ? succesProductsList(
                                      state.getAllProductsModel)
                                  : Center(
                                      child: Text(
                                        "There are some ERRORS, please try again later",
                                        style: textStyle(),
                                      ),
                                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder<GetAllProductsCubit, Object?> succesProductsList(
      GetAllProductsModel getAllProductsModel) {
    return BlocBuilder(
      bloc: getAllProductsCubit,
      builder: (context, getAllCubitState) {
        return getAllCubitState is GetAllStateChangeGroupValue
            ? Scrollbar(
                thickness: 8.w,
                controller: scrollController,
                thumbVisibility: true,
                trackVisibility: true,
                radius: Radius.circular(4.r),
                child: getAllProductsModel.data.isEmpty
                    ? Center(
                        child: Text(
                          'There is no products available',
                          style: textStyle(),
                        ),
                      )
                    : ListView.separated(
                        controller: scrollController,
                        itemCount: getAllProductsModel.data.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return 4.verticalSpace;
                        },
                        itemBuilder: (BuildContext context, int index) {
                          var data = getAllProductsModel.data[index];
                          return SizedBox(
                            height: 38.h,
                            child: CheckboxListTile.adaptive(
                              value: /*  data.products ==
                                                  getAllCubitState.groubValue */
                                  getProductsBloc.checkedBoxValues[index],
                              activeColor: AppColors.ffF05A27OrangeColor,
                              onChanged: (value) {
                                chooseMontageCheckBoxFunction(index, data);
                              },
                              // selected: true,
                              title: Text(
                                data.products,
                                style: textStyle(size: 12),
                              ),
                            ),
                          );
                        },
                      ))
            : 0.horizontalSpace;
      },
    );
  }

  void chooseMontageCheckBoxFunction(int index, AllProductsDatum data) {
    getProductsBloc.checkedBoxValues[index] =
        !getProductsBloc.checkedBoxValues[index];

    getProductsBloc.checkedBoxValues[index]
        ? getAllProductsCubit.selectedProduct.add(
            {'name': data.products, 'id': data.id, 'Quantity': 1, 'price': 100})
        : getAllProductsCubit.selectedProduct.removeAt(index);
    getAllProductsCubit.changeGroupValue(data.products);
  }
}
