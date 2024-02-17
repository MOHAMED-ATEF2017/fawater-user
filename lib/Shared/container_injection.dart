import 'package:kiwi/kiwi.dart';

import '../Controllers/AddNewProductBloc/add_product_bloc.dart';
import '../Controllers/AddRemoveFavoriteBloc/add_remove_favorite_bloc.dart';
import '../Controllers/BillDetailsBloc/bill_details_bloc.dart';
import '../Controllers/ChangePasswordBloc/change_password_bloc.dart';
import '../Controllers/CreateInvoiceBloc/create_invoice_bloc.dart';
import '../Controllers/DeleteAccountBloc/delete_bloc.dart';
import '../Controllers/GetAllProductsBloc/get_all_products_bloc.dart';
import '../Controllers/GetAllProductsBloc/get_all_products_cubit.dart';
import '../Controllers/GetFavoritesBloc/get_favorites_bloc.dart';
import '../Controllers/GetMyStoreFawaterBloc/get_my_fawater_bloc.dart';
import '../Controllers/GetProfileBloc/get_profile_bloc.dart';
import '../Controllers/GetProfileBloc/image_cubit.dart';
import '../Controllers/GetStoreBranchesBloc/get_store_branches_bloc.dart';
import '../Controllers/HomeBloc/home_bloc.dart';
import '../Controllers/HomeBloc/home_cubit.dart';
import '../Controllers/LoginBloc/login_bloc.dart';
import '../Controllers/LoginBloc/login_cubit.dart';
import '../Controllers/LogoutBloc/logout_bloc.dart';
import '../Controllers/NotificationBloc/notification_bloc.dart';
import '../Controllers/RatingBloc/rating_bloc.dart';
import '../Controllers/SignUpBloc/sign_up_bloc.dart';
import '../Controllers/UpdateProfilebloc/update_profile_bloc.dart';

void initKiwi() {
  KiwiContainer container = KiwiContainer();

  container.registerFactory((c) => LoginBloc());
  container.registerFactory((c) => LoginCubit());
  container.registerFactory((c) => HomeBloc());
  container.registerFactory((c) => LogoutBloc());
  container.registerFactory((c) => GetProfileBloc());
  container.registerFactory((c) => ImageCubit());
  container.registerFactory((c) => UpdateProfileBloc());
  container.registerFactory((c) => ChangePasswordBloc());
  container.registerFactory((c) => SignUpBloc());
  container.registerFactory((c) => HomeCubit());
  container.registerFactory((c) => GetAllProductsBloc());
  container.registerFactory((c) => GetAllProductsCubit());
  container.registerFactory((c) => CreateInvoiceBloc());
  container.registerFactory((c) => BillDetailsBloc());
  container.registerFactory((c) => GetFavoritesBloc());
  container.registerFactory((c) => AddRemoveFavoriteBloc());
  container.registerFactory((c) => AddNewProductBloc());
  container.registerFactory((c) => StoreBranchesBloc());
  container.registerFactory((c) => RatingBloc());
  container.registerFactory((c) => NotificationBloc());
  container.registerFactory((c) => GetMyStoreFawaterBloc());
  container.registerFactory((c) => DeleteAccountBloc());
}
