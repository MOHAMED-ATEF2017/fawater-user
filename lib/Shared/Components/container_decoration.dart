 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

BoxDecoration customContainerBoxDecoration({Color ? color , double ?radius}) {
    return BoxDecoration(
        color:color?? Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(.15), blurRadius: 2.r)
        ],
        borderRadius: BorderRadius.circular((radius?? 12).r));
  }