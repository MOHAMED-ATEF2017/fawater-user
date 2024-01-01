import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/AddNewProductBloc/add_product_bloc.dart';
import '../../../Controllers/AddNewProductBloc/add_product_collect_data.dart';
import '../../../Controllers/AddNewProductBloc/add_product_event.dart';
import '../../../Controllers/AddNewProductBloc/add_product_state.dart';
import '../../../Shared/Components/container_button.dart';
import '../../../Shared/Components/container_decoration.dart';
import '../../../Shared/Constants/app_colors.dart';
import '../../../Shared/Constants/constant_strings.dart';
import 'create_by_image.dart';

class AddNewMontageDialogContainer extends StatelessWidget {
  AddNewMontageDialogContainer({
    super.key,
  });
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final AddNewProductBloc addNewProductBloc =
        KiwiContainer().resolve<AddNewProductBloc>();
    AddNewProductCollectData addNewProductCollectData =
        AddNewProductCollectData();
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: 343.w,
        decoration: customContainerBoxDecoration(),
        margin: EdgeInsets.symmetric(
            vertical: context.mediaQuery.viewInsets.bottom != 0 ? 25.h : 190.h,
            horizontal: 30.w),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CreateByImageFatoraTextFeild(
                    onSaved: (p0) {
                      addNewProductCollectData.name = p0;
                    },
                    validator: (p0) {
                      return p0!.isEmpty ? 'Please enter data' : null;
                    },
                    title: 'ادخال اسم المنتج',
                    hint: 'ادخل اسم منتجك هنا'),
                16.verticalSpace,
                CreateByImageFatoraTextFeild(
                    onSaved: (p0) {
                      addNewProductCollectData.price = p0;
                    },
                    validator: (p0) {
                      return p0!.isEmpty ? 'Please enter data' : null;
                    },
                    title: 'ادخال سعر المنتج',
                    hint: 'ادخل سعر الوحده من منتجك هنا'),
                16.verticalSpace,
                // CreateByImageFatoraTextFeild(
                //     onSaved: (p0) {},
                //     validator: (p0) {
                //       return null;
                //     },
                //     title: 'اختر كمية منتجك هنا',
                //     hint: 'ادخل سعر الوحده من منتجك هنا'),
                16.verticalSpace,
                BlocBuilder(
                  bloc: addNewProductBloc,
                  builder: (context, state) {
                    return state is AddProductStateStart
                        ? const Center(
                            child: CupertinoActivityIndicator(),
                          )
                        : Row(
                            children: [
                              Expanded(
                                  child: CustomContainerButton(
                                title: AppStrings.addNewMontag,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    addNewProductBloc.add(AddProductEventStart(
                                        addNewProductCollectData:
                                            addNewProductCollectData));
                                  }
                                },
                              )),
                              12.horizontalSpace,
                              Expanded(
                                  child: CustomContainerButton(
                                title: AppStrings.cancel,
                                onPressed: () => Get.back(),
                                color: AppColors.ffFEEFE9PrimaryLight,
                                textColor: AppColors.ffF05A27OrangeColor,
                                borderColor: Colors.transparent,
                              )),
                            ],
                          );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
