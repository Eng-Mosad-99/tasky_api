import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/data/datasources/remote/refresh_token_remote_data_source.dart';
import 'package:tasky_api/features/auth/data/datasources/remote/register_remote_data_source.dart';
import 'package:tasky_api/features/auth/domain/entities/login_response_entity.dart';
import 'package:tasky_api/features/auth/domain/entities/logout_response_entity.dart';
import 'package:tasky_api/features/auth/domain/entities/profile_response_entity.dart';
import 'package:tasky_api/features/auth/domain/entities/refresh_token_response_entity.dart';
import 'package:tasky_api/features/auth/domain/entities/register_response_entity.dart';
import 'package:tasky_api/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky_api/features/auth/requests/login_request_body.dart';
import 'package:tasky_api/features/auth/requests/register_request_body.dart';
import '../datasources/remote/login_remote_data_source.dart';
import '../datasources/remote/logout_remote_data_source.dart';
import '../datasources/remote/profile_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RegisterRemoteDataSource registerRemoteDataSource;
  final LoginRemoteDataSource loginRemoteDataSource;
  final LogoutRemoteDataSource logoutRemoteDataSource;
  final ProfileRemoteDataSource profileRemoteDataSource;
  final RefreshTokenRemoteDataSource refreshTokenRemoteDataSource;
  AuthRepositoryImpl({
    required this.registerRemoteDataSource,
    required this.loginRemoteDataSource,
    required this.logoutRemoteDataSource,
    required this.profileRemoteDataSource,
    required this.refreshTokenRemoteDataSource,
  });

  @override
  Future<Either<Failure, RegisterResponseEntity>> register(
    RegisterRequestBody requestBody,
  ) async {
    return await registerRemoteDataSource.register(requestBody);
  }

  @override
  Future<Either<Failure, LoginResponseEntity>> login(
    LoginRequestBody requestBody,
  ) async {
    return await loginRemoteDataSource.login(requestBody);
  }

  @override
  Future<Either<Failure, LogoutResponseEntity>> logout() async {
    return await logoutRemoteDataSource.logout();
  }

  @override
  Future<Either<Failure, ProfileResponseEntity>> getProfile() async {
    return await profileRemoteDataSource.getProfile();
  }

  @override
  Future<Either<Failure, RefreshTokenResponseEntity>> refreshToken() async {
    return await refreshTokenRemoteDataSource.refreshToken();
  }
}
