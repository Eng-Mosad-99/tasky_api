import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/register_response_entity.dart';
import 'package:tasky_api/features/auth/domain/repositories/auth_repository.dart';
import 'package:tasky_api/features/auth/requests/register_request_body.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<Either<Failure, RegisterResponseEntity>> call(
    RegisterRequestBody registerRequestBody,
  ) async {
    return await repository.register(registerRequestBody);
  }
}
