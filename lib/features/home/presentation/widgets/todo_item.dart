import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_api/core/utils/app_assets.dart';
import 'package:tasky_api/features/home/domain/entities/todos_response_entity.dart';
import 'package:tasky_api/features/home/presentation/cubit/home_cubit.dart';
import 'package:tasky_api/features/home/presentation/widgets/build_priority.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/format_date.dart';
import 'build_todo_status.dart';
import 'show_custom_menu.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.todo});
  final TodosResponseEntity todo;
  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  final GlobalKey _menuKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 65.w,
            height: 65.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(65.r),
            ),
            child: Image.asset(
              AppAssets.cartImage,
              width: 65.w,
              height: 65.h,
              fit: BoxFit.fill,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.todo.title ?? '',
                        style: AppStyles.bold(color: AppColors.blackColor),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    BuildTodoStatus(statusTitle: widget.todo.status ?? ''),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  widget.todo.desc ?? '',
                  style: AppStyles.regular(
                    color: AppColors.blackColor.withValues(alpha: .6),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    BuildPriority(priorityName: widget.todo.priority ?? ''),
                    const Spacer(),
                    Text(
                      formatDate(widget.todo.createdAt ?? ''),
                      style: TextStyle(color: Colors.grey.shade500),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            key: _menuKey,
            onTap: () {
              showCustomMenu(context, _menuKey, () {
                context.read<HomeCubit>().deleteTodo(widget.todo.sId ?? '');
              });
            },
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(2, size.height);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawShadow(path, Colors.black26, 4, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
