import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kiwi/kiwi.dart';

import '../../Controllers/HomeBloc/home_bloc.dart';
import '../../Controllers/HomeBloc/home_event.dart';
import '../../Modules/HomeModules/home_app_bar.dart';
import '../../Modules/HomeModules/home_create_analysis_inkwells.dart';
import '../../Modules/HomeModules/home_my_location_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeBloc homeBloc = KiwiContainer().resolve<HomeBloc>();
    homeBloc.add(HomeEventDataStart());

    return SizedBox(
      height: 1.sh,
      child: Stack(
        // clipBehavior: Clip.none,
        children: [
          const HomeAppBar(),
          //*************** my location ************ */
          const HomeMyLocationText(),

          //*************** Fawater Containers And Remaining screen  ************ */
          HomeCreateAndAnalysisInkwells(
            homeBloc: homeBloc,
          )
        ],
      ),
    );
  }
}
