import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/register_response_entity.dart';
import 'package:tasky_api/features/auth/requests/register_request_body.dart';

abstract class RegisterRemoteDataSource {
  Future<Either<Failure, RegisterResponseEntity>> register(
    RegisterRequestBody request,
  );
}
