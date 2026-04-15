import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import 'package:tasky_api/core/utils/app_styles.dart';
import 'package:tasky_api/features/home/presentation/cubit/home_cubit.dart';

class AddImageBox extends StatelessWidget {
  const AddImageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        radius: Radius.circular(12.r),
        color: AppColors.colorPrimary,
        strokeWidth: .5,
      ),

      child: Container(
        height: 56.h,

        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
        width: double.infinity,
        alignment: Alignment.center,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            var cubit = context.read<HomeCubit>();

            return GestureDetector(
              onTap: cubit.pickImage,
              child: cubit.selectedImagePath == null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppIcons.uploadImgIcon),
                        SizedBox(width: 8),
                        Text(
                          "Add Img",
                          style: AppStyles.medium(fontSize: 19.sp),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.file(
                        File(cubit.selectedImagePath!),
                        width: double.infinity,
                        height: 56.h,
                        fit: BoxFit.cover,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
