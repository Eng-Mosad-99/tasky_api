import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/login_response_entity.dart';
import 'package:tasky_api/features/auth/domain/repositories/auth_repository.dart';

import '../../requests/login_request_body.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<Failure, LoginResponseEntity>> call(
    LoginRequestBody loginRequestBody,
  ) async {
    return await repository.login(loginRequestBody);
  }
}
