
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';

class TodoTabItem extends StatelessWidget {
  const TodoTabItem({
    super.key,
    required this.todoName,
    required this.isSelected,
  });

  final String todoName;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.colorPrimary
            : AppColors.lightRedColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Text(
        todoName,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey, 
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}