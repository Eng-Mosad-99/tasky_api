import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/login_response_entity.dart';
import 'package:tasky_api/features/auth/domain/entities/register_response_entity.dart';
import 'package:tasky_api/features/auth/requests/register_request_body.dart';

import '../../requests/login_request_body.dart';
import '../entities/logout_response_entity.dart';
import '../entities/profile_response_entity.dart';
import '../entities/refresh_token_response_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponseEntity>> register(RegisterRequestBody requestBody);
  Future<Either<Failure, LoginResponseEntity>> login(LoginRequestBody requestBody);
  Future<Either<Failure, LogoutResponseEntity>> logout();
  Future<Either<Failure, ProfileResponseEntity>> getProfile();
  Future<Either<Failure, RefreshTokenResponseEntity>> refreshToken();
}
