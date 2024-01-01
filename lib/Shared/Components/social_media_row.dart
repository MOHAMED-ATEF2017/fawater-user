import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../gen/assets.gen.dart';


class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.icons.google.svg(),
          12.horizontalSpace,
          Assets.icons.facebook.svg(),
          12.horizontalSpace,
          Assets.icons.apple.svg(),
        ],
      ),
    );
  }
}

