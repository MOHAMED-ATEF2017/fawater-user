import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_bloc.dart';
import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_collect_data.dart';
import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_event.dart';
import 'package:fawatery_user/Controllers/CreateInvoiceBloc/create_invoice_state.dart';
import 'package:fawatery_user/Controllers/GetAllProductsBloc/get_all_products_bloc.dart';
import 'package:fawatery_user/Controllers/HomeBloc/home_cubit.dart';
import 'package:fawatery_user/Shared/Components/container_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kiwi/kiwi.dart';

import '../../../Controllers/GetAllProductsBloc/get_all_products_cubit.dart';
import '../../../Controllers/GetAllProductsBloc/get_all_products_event.dart';
import '../../../Shared/Constants/constant_strings.dart';
import 'choose_matgar_expansion_tile.dart';
import 'choose_montag_expansion_tile.dart';
import 'selected_product_grid_view.dart';

class CreateFatoraByDetailsBody extends StatelessWidget {
  const CreateFatoraByDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final GetAllProductsBloc getProductsBloc =
        KiwiContainer().resolve<GetAllProductsBloc>();

    final GetAllProductsCubit getAllProductsCubit =
        KiwiContainer().resolve<GetAllProductsCubit>();

    final HomeCubit homeBloc = KiwiContainer().resolve<HomeCubit>();

    final CreateInvoiceBloc createInvoiceBloc =
        KiwiContainer().resolve<CreateInvoiceBloc>();

    ScrollController scrollController = ScrollController();

    CreateInvoiceCollectData createInvoiceCollectData =
        CreateInvoiceCollectData();

    getProductsBloc.add(GetAllProductsEventStart());
    getAllProductsCubit.changeGroupValue('');
    // homeBloc.changeGroupValue('');

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          16.verticalSpace,

          //******************choose matgar *******************  */
          MatgarNameAtCreateFatoraByDetailsExpansionTile(homeCubit: homeBloc),
          16.verticalSpace,

          //******************* choose product ****************** */
          ChooseMontageAtCreateFatoraByDetailsExpansionTile(
            getProductsBloc: getProductsBloc,
            getAllProductsCubit: getAllProductsCubit,
            scrollController: scrollController,
          ),

          16.verticalSpace,
          SelectedProductsGridView(
              getAllProductsCubit: getAllProductsCubit,
              // getProductsBloc: getProductsBloc
              ),

          60.verticalSpace,
          BlocBuilder(
            bloc: createInvoiceBloc,
            builder: (context, state) {
              return state is CreateInvoiceByDetailsStateStart
                  ? const CupertinoActivityIndicator()
                  : CustomContainerButton(
                      title: AppStrings.creatFatora,
                      width: .9.sw,
                      onPressed: () {
                        createFatoraFunction(homeBloc, getAllProductsCubit,
                            createInvoiceCollectData, createInvoiceBloc);
                      },
                    );
            },
          ),

          60.verticalSpace,
        ],
      ),
    );
  }

  void createFatoraFunction(
      HomeCubit homeBloc,
      GetAllProductsCubit getProductsBloc,
      CreateInvoiceCollectData createInvoiceCollectData,
      CreateInvoiceBloc createInvoiceBloc) {
    if (homeBloc.radioValueId == '' ||
        getProductsBloc.selectedProduct.isEmpty) {
      Get.snackbar("WARNING", 'Please fill all data');
    } else {
      createInvoiceCollectData.dateInvoice = DateTime.now().toIso8601String();
      createInvoiceCollectData.products = getProductsBloc.selectedProduct;
      createInvoiceCollectData.storeId = homeBloc.radioValueId;
      late int total = 0;
      for (var i = 0; i < getProductsBloc.selectedProduct.length; i++) {
        total = total +
            int.parse((getProductsBloc.selectedProduct[i]['price'] *getProductsBloc.selectedProduct[i]['Quantity'] ).toString());
      }
      createInvoiceCollectData.totalInvoice = total.toString();
      createInvoiceBloc.add(CreateInvoiceByDetailsEventStart(
          createInvoiceCollectData: createInvoiceCollectData));

      // Get.dialog(const AddFatoraSuccessDialogeContainer());
    }
  }
}
