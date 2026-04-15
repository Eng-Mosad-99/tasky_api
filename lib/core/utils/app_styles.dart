import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_api/core/utils/app_colors.dart';

class AppStyles {
  static TextStyle regular({double fontSize = 14.0, Color color = AppColors.colorPrimary , TextDecoration? decoration}) {
    return TextStyle(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: FontWeight.w400,
      decoration: decoration,
    );
  }
  static TextStyle medium({double fontSize = 15.0, Color color = AppColors.colorPrimary , TextDecoration? decoration}) {
    return TextStyle(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: FontWeight.w500,
      decoration: decoration,
    );
  }
  static TextStyle bold({double fontSize = 16.0, Color color = AppColors.colorPrimary , TextDecoration? decoration}) {
    return TextStyle(
      fontSize: fontSize.sp,
      color: color,
      fontWeight: FontWeight.w700,
      decoration: decoration,
    );
  }
  static TextStyle medium18Header = TextStyle(
    fontSize: 18.sp,
    color: AppColors.colorPrimary,
    fontWeight: FontWeight.w500,
  );
}