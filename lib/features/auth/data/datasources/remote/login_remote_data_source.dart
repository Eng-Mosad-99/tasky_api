import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/login_response_entity.dart';
import '../../../requests/login_request_body.dart';

abstract class LoginRemoteDataSource {
  Future<Either<Failure, LoginResponseEntity>> login(
    LoginRequestBody request,
  );
}
