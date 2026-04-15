import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class BuildTodoStatus extends StatelessWidget {
  const BuildTodoStatus({super.key, required this.statusTitle});
  final String statusTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        color: statusTitle == 'waiting'
            ? AppColors.waitingColor
            : statusTitle == 'inProgress'
            ? AppColors.inProgressColor
            : AppColors.finishedColor,
      ),
      child: Text(
        statusTitle,
        style: AppStyles.medium(
          color: statusTitle == 'waiting'
              ? AppColors.waitingTextColor
              : statusTitle == 'inProgress'
              ? AppColors.colorPrimary
              : AppColors.finishedTextColor,
        ),
      ),
    );
  }
}
