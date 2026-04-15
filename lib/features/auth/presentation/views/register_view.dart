import 'dart:developer';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import 'package:tasky_api/core/utils/app_routes.dart';
import 'package:tasky_api/core/utils/app_styles.dart';
import 'package:tasky_api/core/utils/dialog_utils.dart';
import 'package:tasky_api/core/widgets/custom_button.dart';
import 'package:tasky_api/core/widgets/custom_text_form_field.dart';
import 'package:tasky_api/features/auth/presentation/cubit/auth_cubit.dart';
import '../../../../core/cache/cache_helper.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    AuthCubit authCubit = getIt<AuthCubit>();
    return BlocProvider(
      create: (context) => authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            DialogUtils.showLoading(context: context, message: 'Loading..');
          } else if (state is RegisterFailureState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Error',
              context: context,
              message: state.message,
              posActionName: 'ok',
            );
          } else if (state is RegisterSuccessState) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Success',
              context: context,
              message: 'Register Successfully',
              posActionName: 'ok',
              posAction: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              },
            );
            var accessToken = state.registerResponse.accessToken;
            var refreshToken = state.registerResponse.refreshToken;
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Image.asset(
                      AppAssets.onboardingGirlImage,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      height: 250.h,
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16.h)),
                  SliverToBoxAdapter(
                    child: Text(
                      'Register',
                      style: AppStyles.bold(
                        fontSize: 24.sp,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: authCubit.displayNameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      hntText: 'Name..',
                      hintStyle: AppStyles.regular(color: AppColors.greyColor),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: authCubit.phoneController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a phone';
                        }
                        if (value.length < 5) {
                          return 'phone must be at least 5 characters long';
                        }
                        return null;
                      },

                      keyboardType: TextInputType.phone,
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
                      hintStyle: AppStyles.regular(color: AppColors.greyColor),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: authCubit.experienceYearsController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the year of experience';
                        }
                        return null;
                      },
                      hntText: 'year of experience',
                      hintStyle: AppStyles.regular(color: AppColors.greyColor),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          height: 50.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              width: 1,
                              color: const Color(0xffBABABA),
                            ),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.fieldNameColor,
                              size: 24,
                            ),
                            underline: Container(),
                            value: authCubit.selectedLevel,
                            hint: Text(
                              'Choose experience Level',
                              style: AppStyles.regular(
                                color: AppColors.dropdownMenuColor,
                                fontSize: 15.sp,
                              ),
                            ),
                            onChanged: (String? newValue) {
                              authCubit.changeLevel(newValue);
                            },
                            items: authCubit.levels
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: AppStyles.regular(
                                        color: AppColors.dropdownMenuColor,
                                        fontSize: 15.sp,
                                      ),
                                    ),
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      );
                    },
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: authCubit.addressController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter an address';
                        }
                        return null;
                      },
                      hntText: 'Address..',
                      hintStyle: AppStyles.regular(color: AppColors.greyColor),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  SliverToBoxAdapter(
                    child: CustomTextFormField(
                      controller: authCubit.passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },

                      hntText: 'Password',
                      hintStyle: AppStyles.regular(color: AppColors.greyColor),
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(8.sp),
                        child: SvgPicture.asset(AppIcons.eyeIcon),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverToBoxAdapter(
                    child: CustomButton(
                      text: 'Sign Up',
                      textStyle: AppStyles.bold(color: AppColors.whiteColor),

                      onPressed: () {
                        authCubit.register();
                      },
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  SliverToBoxAdapter(
                    child: Align(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have any account?',
                              style: AppStyles.regular(
                                color: AppColors.greyColor,
                              ),
                            ),
                            TextSpan(
                              text: ' Sign In',
                              style: AppStyles.bold(
                                color: AppColors.colorPrimary,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
