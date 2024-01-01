// import 'package:fawatery_user/Controllers/HomeBloc/home_state.dart';
import 'package:fawatery_user/Screens/MainScreen/main_screen.dart';
import 'package:fawatery_user/Shared/functions/navigate_fadin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Modules/CreateFatoraModules/CreateModules/create_fatora_body.dart';
import '../../Modules/CreateFatoraModules/MyFawaterModules/my_fawater_body.dart';
import '../../Shared/Components/container_button.dart';
import '../../Shared/Components/container_decoration.dart';
import '../../Shared/Components/text_style.dart';
import '../../Shared/Constants/app_colors.dart';
import '../../Shared/Constants/constant_strings.dart';
import '../../gen/assets.gen.dart';

class CreateBillsScreen extends StatelessWidget {
  const CreateBillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final HomeCubit indexCubit = KiwiContainer().resolve<HomeCubit>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.alfwater),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            CustomNavigation.fadeInGetOffAllNavigateFunction(
                const MainScreen());
          },
        ),
      ),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              TabBar(
                  labelStyle: textStyle(color: AppColors.ffF05A27OrangeColor),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: EdgeInsets.symmetric(
                    horizontal: 35.w,
                  ),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  indicatorWeight: 4,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: AppColors.ffC1C2C3Icons,
                  labelColor: AppColors.ffF05A27OrangeColor,
                  indicatorColor: AppColors.ffF05A27OrangeColor,
                  labelPadding: EdgeInsets.only(bottom: 10.h),
                  // onTap: (index) {
                  //   indexCubit.onIndexTapped(index);
                  // },
                  tabs: const [
                    Text(AppStrings.fawatery),
                    Text(AppStrings.creatFatora),
                  ]),
              const Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [MyFawaterBody(), CreateFatoraBody()],
                ),
              ),
            ],
          )),
      // floatingActionButton: BlocBuilder(
      //     bloc: indexCubit,
      //     builder: (context, state) {
      //       return state is HomeStateSelectedIndex
      //           ? state.selectedIndex != 0
      //               ? CustomContainerButton(
      //                   title: AppStrings.creatFatora,
      //                   width: .9.sw,
      //                   onPressed: () {
      //                     Get.dialog(const AddFatoraSuccessDialogeContainer());
      //                   },
      //                 )
      //               : const SizedBox.shrink()
      //           : const SizedBox.shrink();
      //     }),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class AddFatoraSuccessDialogeContainer extends StatelessWidget {
  const AddFatoraSuccessDialogeContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsetsDirectional.only(
            top: 150.h, bottom: 280.h, start: 50.w, end: 50.w),
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        decoration: customContainerBoxDecoration(),
        child: Column(
          children: [
            24.verticalSpace,
            Assets.lotties.addFatora.lottie(),
            16.verticalSpace,
            Text(
              'تم اضافة الفاتورة بنجاح',
              style: textStyle(size: 16),
            ),
            16.verticalSpace,
            Text(
              'أصبح لديك 20 نقطة في حسابك',
              style: textStyle(weight: FontWeight.w500),
            ),
            16.verticalSpace,
            CustomContainerButton(
              title: 'عرض',
              onPressed: () => Get.back(),
            )
          ],
        ));
  }
}
