import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/refresh_token_response_entity.dart';

abstract class RefreshTokenRemoteDataSource {
  Future<Either<Failure, RefreshTokenResponseEntity>> refreshToken();
}
