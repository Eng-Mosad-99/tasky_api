import 'package:get_it/get_it.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/cache/cache_helper.dart';
import 'package:tasky_api/features/auth/data/datasources/remote/impl/refresh_token_remote_data_source_impl.dart';
import 'package:tasky_api/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tasky_api/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:tasky_api/features/home/data/datasources/remote/impl/todos_remote_data_source_impl.dart';
import 'package:tasky_api/features/home/data/repositories/todos_repository_impl.dart';
import 'package:tasky_api/features/home/domain/usecases/create_todo_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/delete_todo_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/get_one_todo_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/todos_use_case.dart';
import 'package:tasky_api/features/home/domain/usecases/upload_todo_image_use_case.dart';
import 'package:tasky_api/features/home/presentation/cubit/home_cubit.dart';
import '../../features/auth/data/datasources/remote/impl/login_remote_data_source_impl.dart';
import '../../features/auth/data/datasources/remote/impl/logout_remote_data_source_impl.dart';
import '../../features/auth/data/datasources/remote/impl/profile_remote_data_source_impl.dart';
import '../../features/auth/data/datasources/remote/impl/register_remote_data_source_impl.dart';
import '../../features/auth/domain/usecases/login_use_case.dart';
import '../../features/auth/domain/usecases/logout_use_case.dart';
import '../../features/auth/domain/usecases/profile_use_case.dart';
import '../../features/auth/domain/usecases/refresh_token_use_case.dart';
import '../../features/auth/domain/usecases/register_use_case.dart';
import '../network/network_service.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerSingleton<API>(API());
    getIt.registerSingleton<NetworkServiceImpl>(NetworkServiceImpl());
    getIt.registerLazySingleton<CacheHelper>(() => CacheHelper());

    //! DataSources
    getIt.registerLazySingleton<RegisterRemoteDataSourceImpl>(
      () => RegisterRemoteDataSourceImpl(
        api: getIt<API>(),
        networkService: getIt<NetworkServiceImpl>(),
      ),
    );
    getIt.registerLazySingleton<LoginRemoteDataSourceImpl>(
      () => LoginRemoteDataSourceImpl(
        api: getIt<API>(),
        networkService: getIt<NetworkServiceImpl>(),
      ),
    );
    getIt.registerLazySingleton<LogoutRemoteDataSourceImpl>(
      () => LogoutRemoteDataSourceImpl(
        api: getIt<API>(),
        networkService: getIt<NetworkServiceImpl>(),
      ),
    );
    getIt.registerLazySingleton<ProfileRemoteDataSourceImpl>(
      () => ProfileRemoteDataSourceImpl(
        api: getIt<API>(),
        networkService: getIt<NetworkServiceImpl>(),
      ),
    );
    getIt.registerLazySingleton<RefreshTokenRemoteDataSourceImpl>(
      () => RefreshTokenRemoteDataSourceImpl(
        api: getIt<API>(),
        networkService: getIt<NetworkServiceImpl>(),
      ),
    );
    getIt.registerLazySingleton<TodosRemoteDataSourceImpl>(
      () => TodosRemoteDataSourceImpl(
        api: getIt<API>(),
        networkService: getIt<NetworkServiceImpl>(),
      ),
    );

    //! Repositories
    getIt.registerLazySingleton<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(
        registerRemoteDataSource: getIt<RegisterRemoteDataSourceImpl>(),
        loginRemoteDataSource: getIt<LoginRemoteDataSourceImpl>(),
        logoutRemoteDataSource: getIt<LogoutRemoteDataSourceImpl>(),
        profileRemoteDataSource: getIt<ProfileRemoteDataSourceImpl>(),
        refreshTokenRemoteDataSource: getIt<RefreshTokenRemoteDataSourceImpl>(),
      ),
    );
    getIt.registerLazySingleton<TodosRepositoryImpl>(
      () => TodosRepositoryImpl(
        todosRemoteDataSource: getIt<TodosRemoteDataSourceImpl>(),
      ),
    );

    //! Use Cases
    getIt.registerLazySingleton<RegisterUseCase>(
      () => RegisterUseCase(repository: getIt<AuthRepositoryImpl>()),
    );
    getIt.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(repository: getIt<AuthRepositoryImpl>()),
    );
    getIt.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repository: getIt<AuthRepositoryImpl>()),
    );
    getIt.registerLazySingleton<ProfileUseCase>(
      () => ProfileUseCase(repository: getIt<AuthRepositoryImpl>()),
    );
    getIt.registerLazySingleton<RefreshTokenUseCase>(
      () => RefreshTokenUseCase(repository: getIt<AuthRepositoryImpl>()),
    );
    getIt.registerLazySingleton<TodosUseCase>(
      () => TodosUseCase(todosRepository: getIt<TodosRepositoryImpl>()),
    );
    getIt.registerLazySingleton<GetOneTodoUseCase>(
      () => GetOneTodoUseCase(todosRepository: getIt<TodosRepositoryImpl>()),
    );
    getIt.registerLazySingleton<UploadTodoImageUseCase>(
      () =>
          UploadTodoImageUseCase(todosRepository: getIt<TodosRepositoryImpl>()),
    );
    getIt.registerLazySingleton<CreateTodoUseCase>(
      () => CreateTodoUseCase(getIt<TodosRepositoryImpl>()),
    );
    getIt.registerLazySingleton<DeleteTodoUseCase>(
      () => DeleteTodoUseCase(getIt<TodosRepositoryImpl>()),
    );

    //! Cubits
    getIt.registerFactory<AuthCubit>(
      () => AuthCubit(
        getIt<RegisterUseCase>(),
        getIt<LoginUseCase>(),
        getIt<LogoutUseCase>(),
        getIt<ProfileUseCase>(),
        getIt<RefreshTokenUseCase>(),
      ),
    );

    getIt.registerFactory<HomeCubit>(
      () => HomeCubit(
        getIt<TodosUseCase>(),
        getIt<GetOneTodoUseCase>(),
        getIt<UploadTodoImageUseCase>(),
        getIt<CreateTodoUseCase>(),
        getIt<DeleteTodoUseCase>(),
      ),
    );
  }
}
