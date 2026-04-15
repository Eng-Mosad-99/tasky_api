import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import 'package:tasky_api/core/utils/app_routes.dart';
import 'package:tasky_api/core/utils/app_styles.dart';
import 'package:tasky_api/core/utils/dialog_utils.dart';
import 'package:tasky_api/core/widgets/build_border.dart';
import 'package:tasky_api/core/widgets/custom_button.dart';
import 'package:tasky_api/features/home/presentation/cubit/home_cubit.dart';
import 'package:tasky_api/features/home/presentation/widgets/add_image_box_widget.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = getIt<HomeCubit>();
    return BlocProvider(
      create: (context) => homeCubit,
      child: BlocListener<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is CreateTodoLoading) {
            DialogUtils.showLoading(context: context, message: 'Creating...');
          } else if (state is CreateTodoFailure) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Error',
              context: context,
              message: state.errorMsg,
              posActionName: 'ok',
            );
          } else if (state is CreateTodoSuccess) {
            DialogUtils.hideLoading(context);
            DialogUtils.showMessage(
              title: 'Success',
              context: context,
              message: 'Created Successfully',
              posActionName: 'ok',
              posAction: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.home,
                  (route) => false,
                );
              },
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: SingleChildScrollView(
                child: Form(
                  key: homeCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      AddImageBox(),
                      SizedBox(height: 16.h),
                      AddTaskTitleAndFormField(
                        controller: homeCubit.titleController,
                        title: 'Task title',
                        hintText: 'Enter title here...',
                      ),
                      SizedBox(height: 16.h),
                      AddTaskTitleAndFormField(
                        controller: homeCubit.descriptionController,
                        maxLines: 5,
                        title: 'Task Description',
                        hintText: 'Enter description here...',
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Priority',
                        style: AppStyles.regular(
                          fontSize: 12.sp,
                          color: AppColors.boardingGreyColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          String? selectedLevel;

                          if (state is ChangeLevelSuccess) {
                            selectedLevel = state.level;
                          }

                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            height: 50.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                width: 1,
                                color: AppColors.lightRedColor,
                              ),
                            ),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              icon: SvgPicture.asset(
                                AppIcons.arrowDownIcon,
                                color:
                                    homeCubit.selectedLevel?.toLowerCase() ==
                                        'low'
                                    ? AppColors.priorityLowColor
                                    : homeCubit.selectedLevel?.toLowerCase() ==
                                          'high'
                                    ? AppColors.priorityHighColor
                                    : AppColors.priorityMediumColor,
                              ),
                              underline: Container(),
                              value: selectedLevel,
                              hint: Text(
                                'Choose Priority Level',
                                style: AppStyles.regular(
                                  color: AppColors.dropdownMenuColor,
                                  fontSize: 15.sp,
                                ),
                              ),
                              onChanged: (String? newValue) {
                                homeCubit.changeLevel(newValue);
                              },
                              items: homeCubit.priorityLevels
                                  .map<DropdownMenuItem<String>>((
                                    String value,
                                  ) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                            AppIcons.mediumFlagIcon,
                                            color: value.toLowerCase() == 'low'
                                                ? AppColors.priorityLowColor
                                                : value.toLowerCase() == 'high'
                                                ? AppColors.priorityHighColor
                                                : AppColors.priorityMediumColor,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            '$value Priority',
                                            style: AppStyles.bold(
                                              color:
                                                  value.toLowerCase() == 'low'
                                                  ? AppColors.priorityLowColor
                                                  : value.toLowerCase() ==
                                                        'high'
                                                  ? AppColors.priorityHighColor
                                                  : AppColors
                                                        .priorityMediumColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  })
                                  .toList(),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Due Date',
                        style: AppStyles.regular(
                          color: AppColors.boardingGreyColor,
                          fontSize: 12.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {
                          return Container(
                            padding: EdgeInsets.all(15.sp),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                width: 1,
                                color: AppColors.darkGreyColor,
                              ),
                            ),

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  homeCubit.selectedDate == null
                                      ? 'choose due date...'
                                      : homeCubit.formatDate,
                                  style: AppStyles.regular(
                                    color: AppColors.greyColor,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    homeCubit.chooseDate(context);
                                  },
                                  child: SvgPicture.asset(
                                    AppIcons.calendarIcon,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.h),
                      CustomButton(
                        text: 'Add Task',
                        onPressed: () {
                          homeCubit.createTodo();
                        },
                        textStyle: AppStyles.bold(
                          color: Colors.white,
                          fontSize: 19.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AddTaskTitleAndFormField extends StatelessWidget {
  const AddTaskTitleAndFormField({
    super.key,
    required this.title,
    required this.hintText,
    this.maxLines = 1,
    this.controller,
  });

  final String title;
  final String hintText;
  final int maxLines;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final isMultiLine = maxLines > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: AppStyles.regular(
            fontSize: 12.sp,
            color: AppColors.boardingGreyColor,
          ),
        ),
        SizedBox(height: 8.h),

        isMultiLine
            ? TextField(
                controller: controller,
                maxLines: maxLines,
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  hintText: hintText,
                  contentPadding: EdgeInsets.all(12.w),
                  border: buildBorder(),
                  focusedBorder: buildBorder(color: AppColors.colorPrimary),
                ),
              )
            : SizedBox(
                height: 50.h,
                child: TextField(
                  maxLines: 1,
                  controller: controller,
                  style: TextStyle(fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText: hintText,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    border: buildBorder(),
                    focusedBorder: buildBorder(color: AppColors.colorPrimary),
                  ),
                ),
              ),
      ],
    );
  }
}
