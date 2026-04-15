import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/core/utils/app_colors.dart';
import 'package:tasky_api/core/utils/app_routes.dart';
import 'package:tasky_api/core/utils/dialog_utils.dart';
import 'package:tasky_api/core/widgets/format_date.dart';
import 'package:tasky_api/features/home/domain/entities/todos_response_entity.dart';
import 'package:tasky_api/features/home/presentation/cubit/home_cubit.dart';

import '../../../../core/utils/app_styles.dart';
import '../widgets/show_custom_menu.dart';

class TodoDetailsView extends StatefulWidget {
  const TodoDetailsView({super.key, required this.todo});
  final TodosResponseEntity todo;
  @override
  State<TodoDetailsView> createState() => _TodoDetailsViewState();
}

class _TodoDetailsViewState extends State<TodoDetailsView> {
  final GlobalKey _detailsMenuKey = GlobalKey();
  HomeCubit homeCubit = getIt<HomeCubit>();
  @override
  void initState() {
    homeCubit.getOneTodo(widget.todo.sId ?? '');
    super.initState();
  }

  Widget buildImage(String path) {
    if (path.startsWith('http')) {
      return Image.network(path);
    } else {
      return Image.file(File(path));
    }
  }

  @override
  Widget build(BuildContext context) {
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
          appBar: AppBar(
            leadingWidth: 130.w,
            leading: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: SvgPicture.asset(AppIcons.arrowLeftIcon),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Details',
                    style: AppStyles.bold(color: AppColors.blackColor),
                  ),
                ],
              ),
            ),

            actions: [
              InkWell(
                key: _detailsMenuKey,
                onTap: () {
                  showCustomMenu(context, _detailsMenuKey, () {
                    homeCubit.deleteTodo(widget.todo.sId ?? '');
                  });
                },
                child: Icon(Icons.more_vert),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(AppAssets.cartImage, fit: BoxFit.fill),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${widget.todo.title}',
                        style: AppStyles.bold(
                          color: AppColors.blackColor,
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${widget.todo.desc}',
                        style: AppStyles.regular(
                          color: AppColors.blackColor.withValues(alpha: .6),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    children: [
                      Card(
                        color: AppColors.lightRedColor,
                        elevation: 0,

                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(
                              'End Date',
                              style: AppStyles.regular(
                                fontSize: 9.sp,
                                color: AppColors.boardingGreyColor,
                              ),
                            ),
                            subtitle: Text(
                              formatDate(
                                widget.todo.createdAt ?? '',
                                pattern: 'd MMMM, yyyy',
                              ),
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                            trailing: SvgPicture.asset(AppIcons.calendarIcon),
                          ),
                        ),
                      ),
                      Card(
                        color: AppColors.lightRedColor,
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            title: Text(
                              '${widget.todo.status}',
                              style: AppStyles.bold(),
                            ),
                            trailing: SvgPicture.asset(AppIcons.arrowDownIcon),
                          ),
                        ),
                      ),
                      Card(
                        color: AppColors.lightRedColor,
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.zero,
                          child: ListTile(
                            title: Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.mediumFlagIcon,
                                  color:
                                      widget.todo.priority?.toLowerCase() ==
                                          'low'
                                      ? AppColors.priorityLowColor
                                      : widget.todo.priority?.toLowerCase() ==
                                            'high'
                                      ? AppColors.priorityHighColor
                                      : AppColors.priorityMediumColor,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${widget.todo.priority} Priority',
                                  style: AppStyles.bold(
                                    color:
                                        widget.todo.priority?.toLowerCase() ==
                                            'low'
                                        ? AppColors.priorityLowColor
                                        : widget.todo.priority?.toLowerCase() ==
                                              'high'
                                        ? AppColors.priorityHighColor
                                        : AppColors.priorityMediumColor,
                                  ),
                                ),
                              ],
                            ),
                            trailing: SvgPicture.asset(AppIcons.arrowDownIcon),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                QrImageView(
                  data: widget.todo.sId ?? '',
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
