import 'dart:developer';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/gestures.dart';
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
import 'package:tasky_api/core/utils/dialog_utils.dart';
import 'package:tasky_api/core/widgets/custom_button.dart';
import 'package:tasky_api/core/widgets/custom_text_form_field.dart';

import '../cubit/auth_cubit.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = getIt<AuthCubit>();
    return BlocProvider(
      create: (context) => authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            DialogUtils.showLoading(context: context, message: 'Loading..');
          } else if (state is LoginFailureState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Error',
              context: context,
              message: state.message,
              posActionName: 'ok',
            );
          } else if (state is LoginSuccessState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Success',
              context: context,
              message: 'Login Successfully',
              posActionName: 'ok',
              posAction: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              },
            );
            var accessToken = state.loginResponse.accessToken;
            var refreshToken = state.loginResponse.refreshToken;
            getIt<CacheHelper>()
                .saveData(key: 'accessToken', value: accessToken)
                .then((value) {
                  log('Access token saved successfully');
                });
            getIt<CacheHelper>()
                .saveData(key: 'refreshToken', value: refreshToken)
                .then((value) {
                  log('Refresh token saved successfully');
                });
          }
        },

        child: Scaffold(
          body: Form(
            key: authCubit.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  AppAssets.onboardingGirlImage,
                  fit: BoxFit.fill,
                  height: 400.h,
                  width: double.infinity,
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Login',
                          style: AppStyles.bold(
                            fontSize: 24.sp,
                            color: AppColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          prefixIcon: CountryListPick(
                            theme: CountryTheme(
                              isShowFlag: true,
                              isShowTitle: false,
                              isShowCode: true,
                              isDownIcon: true,
                              showEnglishName: false,
                            ),
                            initialSelection: authCubit.selectedCountryCode,
                            onChanged: (CountryCode? code) {
                              authCubit.changeCountryCode(code!);
                            },

                            useUiOverlay: true,
                            useSafeArea: false,
                          ),
                          hntText: '123 456-7890',
                          hintStyle: AppStyles.regular(
                            color: AppColors.greyColor,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        CustomTextFormField(
                          controller: authCubit.passwordController,
                          hntText: 'Password...',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hintStyle: AppStyles.regular(
                            color: AppColors.greyColor,
                          ),
                          suffixIcon: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: SvgPicture.asset(AppIcons.eyeIcon),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 24.h),
                        CustomButton(
                          text: 'Sign In',
                          onPressed: () {
                            authCubit.login(
                              authCubit.phoneController.text,
                              authCubit.passwordController.text,
                            );
                          },
                          textStyle: AppStyles.bold(color: Colors.white),
                        ),
                        SizedBox(height: 16.h),

                        Text.rich(
                          TextSpan(
                            text: 'Don\'t have an account?',
                            style: AppStyles.regular(
                              color: AppColors.greyColor,
                            ),

                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.register,
                                      (route) => false,
                                    );
                                  },
                                text: ' Sign Up here',

                                style: AppStyles.bold(
                                  fontSize: 14.sp,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
