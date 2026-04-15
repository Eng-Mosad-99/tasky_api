import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasky_api/core/utils/app_assets.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';

class BuildPriority extends StatelessWidget {
  const BuildPriority({super.key, required this.priorityName});
  final String priorityName;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          AppIcons.mediumFlagIcon,
          color: priorityName.toLowerCase() == 'low'
              ? AppColors.priorityLowColor
              : priorityName.toLowerCase() == 'high'
              ? AppColors.priorityHighColor
              : AppColors.priorityMediumColor,
        ),
        SizedBox(width: 4.w),
        Text(
          priorityName,
          style: AppStyles.medium(
            color: priorityName.toLowerCase() == 'low'
                ? AppColors.priorityLowColor
                : priorityName.toLowerCase() == 'high'
                ? AppColors.priorityHighColor
                : AppColors.priorityMediumColor,
          ),
        ),
      ],
    );
  }
}
