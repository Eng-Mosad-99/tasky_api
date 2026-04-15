import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasky_api/core/cache/cache_helper.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import 'package:tasky_api/core/utils/app_routes.dart';
import 'package:tasky_api/core/utils/app_styles.dart';
import 'package:tasky_api/core/widgets/custom_button.dart';
import 'package:tasky_api/features/auth/presentation/cubit/auth_cubit.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AppAssets.onboardingGirlImage,
              fit: BoxFit.fill,
              height: 450.h,
              width: double.infinity,
            ),
            SizedBox(height: 24.h),
            Text.rich(
              TextSpan(
                text: 'Task Management &\n',
                style: AppStyles.bold(
                  color: AppColors.blackColor,
                  fontSize: 24.sp,
                ),

                children: [
                  TextSpan(
                    text: 'To-Do List',
                    style: AppStyles.bold(
                      color: AppColors.blackColor,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            Text.rich(
              TextSpan(
                text: 'This productive tool is designed to help \n',
                style: AppStyles.regular(color: AppColors.boardingGreyColor),
                children: [
                  TextSpan(
                    text: 'you better manage your task \n',
                    style: AppStyles.regular(
                      color: AppColors.boardingGreyColor,
                    ),
                  ),
                  TextSpan(
                    text: 'project-wise conveniently!',
                    style: AppStyles.regular(
                      color: AppColors.boardingGreyColor,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: CustomButton(
                text: 'Let’s Start',
                textStyle: AppStyles.bold(color: Colors.white, fontSize: 19.sp),
                onPressed: () {
                  _navigateToLoginOrOnBoarding(context);
                },
                leadingWidget: SvgPicture.asset(AppIcons.arrowRightIcon),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLoginOrOnBoarding(BuildContext context) {
    var accessToken = getIt<CacheHelper>().getData(key: 'accessToken');
    log('accessToken: $accessToken');
    AuthCubit cubit = getIt<AuthCubit>();
    if (accessToken == null || accessToken == '') {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      cubit.refreshToken();
      Navigator.pushReplacementNamed(context, AppRoutes.home);
    }
  }
}
