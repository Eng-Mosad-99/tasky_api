import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky_api/core/cache/cache_helper.dart';
import 'package:tasky_api/core/di/di.dart';
import 'package:tasky_api/core/utils/app_constants.dart';
import 'package:tasky_api/core/utils/app_routes.dart';
import 'package:tasky_api/core/utils/my_bloc_observer.dart';
import 'package:tasky_api/features/auth/presentation/views/register_view.dart';
import 'package:tasky_api/features/home/domain/entities/todos_response_entity.dart';
import 'package:tasky_api/features/home/presentation/views/add_task_view.dart';
import 'package:tasky_api/features/on_boarding/views/on_boarding_view.dart';

import 'features/auth/presentation/views/login_view.dart';
import 'features/auth/presentation/views/profile_view.dart';
import 'features/home/presentation/views/home_view.dart';
import 'features/home/presentation/views/todo_details_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.setup();
  Bloc.observer = MyBlocObserver();
  await CacheHelper().init();
  runApp(const TaskyApi());
}

class TaskyApi extends StatelessWidget {
  const TaskyApi({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp(
          initialRoute: AppRoutes.onBoardingView,

          routes: {
            AppRoutes.onBoardingView: (_) => const OnBoardingView(),
            AppRoutes.login: (_) => const LoginView(),
            AppRoutes.register: (_) => const RegisterView(),
            AppRoutes.home: (_) => const HomeView(),
            AppRoutes.profile: (_) => const ProfileView(),
            AppRoutes.taskDetails: (context) {
              final args = ModalRoute.of(context)?.settings.arguments;
              return TodoDetailsView(todo: args as TodosResponseEntity);
            },
            AppRoutes.createTask: (_) => const AddTaskView(),
          },
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: AppConstants.kFontFamily),
        );
      },
    );
  }
}
