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
import 'package:tasky_api/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tasky_api/features/home/presentation/cubit/home_cubit.dart';
import '../../../../core/utils/dialog_utils.dart';
import '../widgets/floating_action_button_item.dart';
import '../widgets/todo_item.dart';
import '../widgets/todo_tab_item.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeCubit homeCubit = getIt<HomeCubit>();

  @override
  void initState() {
    super.initState();
    homeCubit.getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = getIt<AuthCubit>();

    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is DeleteTodoLoading) {
            DialogUtils.showLoading(context: context, message: 'Deleting...');
          } else if (state is DeleteTodoFailure) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Error',
              context: context,
              message: state.errorMsg,
              posActionName: 'ok',
            );
          } else if (state is DeleteTodoSuccess) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Success',
              context: context,
              message: 'Deleted Successfully',
              posActionName: 'ok',
              
            );
          }
        },
        child: BlocProvider(
          create: (context) => cubit,
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LogoutLoadingState) {
                DialogUtils.showLoading(context: context, message: 'Loading..');
              } else if (state is LogoutFailureState) {
                DialogUtils.hideLoading(context);
                DialogUtils.showMessage(
                  title: 'Error',
                  context: context,
                  message: state.message,
                  posActionName: 'ok',
                );
              } else if (state is LogoutSuccessState) {
                DialogUtils.hideLoading(context);
                DialogUtils.showMessage(
                  title: 'Success',
                  context: context,
                  message: 'Logout Successfully',
                  posActionName: 'ok',
                  posAction: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                );
                getIt<CacheHelper>().clearData(key: 'accessToken').then((
                  value,
                ) {
                  log('Access token cleared successfully');
                });
              }
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Logo',
                  style: AppStyles.bold(
                    fontSize: 24.sp,
                    color: AppColors.blackColor,
                  ),
                ),
                actions: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.profile),
                    child: SvgPicture.asset(
                      AppIcons.profileIcon,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(16.sp),
                    child: InkWell(
                      onTap: () => cubit.logout(),
                      child: SvgPicture.asset(
                        AppIcons.logoutIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),
                  ),
                ],
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22.w),
                    child: Text(
                      'My Tasks',
                      style: AppStyles.bold(
                        color: AppColors.blackColor.withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return DefaultTabController(
                        length: homeCubit.todoNameList.length,
                        child: TabBar(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          labelColor: Colors.white,
                          indicatorColor: Colors.transparent,
                          dividerColor: Colors.transparent,
                          unselectedLabelColor:
                              AppColors.unSelectedLabelGreyColor,
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelPadding: EdgeInsets.symmetric(horizontal: 5.w),
                          tabAlignment: TabAlignment.start,
                          onTap: (index) {
                            homeCubit.changeSelectedTab(index);
                          },
                          isScrollable: true,
                          tabs: homeCubit.todoNameList.map((e) {
                            return TodoTabItem(
                              isSelected:
                                  homeCubit.todoNameList.indexOf(e) ==
                                  homeCubit.selectedIndex,
                              todoName: e,
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16.h),
                  BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is GetAllTodosFailure) {
                        return Text(
                          state.errorMsg,
                          style: AppStyles.regular(color: Colors.red),
                        );
                      }
                      if (state is GetAllTodosLoading) {
                        return Center(
                          child: CircularProgressIndicator(strokeWidth: 1.w),
                        );
                      }
                      return Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () => Navigator.pushNamed(
                                context,
                                AppRoutes.taskDetails,
                                arguments: homeCubit.filteredTodosList[index],
                              ),
                              child: TodoItem(
                                todo: homeCubit.filteredTodosList[index],
                              ),
                            );
                          },
                          itemCount: homeCubit.filteredTodosList.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
              floatingActionButton: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButtonItem(
                    heroTag: "barcode_fab",
                    floatingImage: AppIcons.barcodeIcon,
                    backgroundColor: AppColors.lightRoseColor,
                    size: 55,
                  ),
                  SizedBox(height: 14.h),
                  FloatingActionButtonItem(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.createTask),
                    heroTag: "add_fab",
                    floatingImage: AppIcons.addIcon,
                    backgroundColor: AppColors.colorPrimary,
                    size: 65,
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
