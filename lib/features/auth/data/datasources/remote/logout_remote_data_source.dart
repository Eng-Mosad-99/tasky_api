import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../../domain/entities/logout_response_entity.dart';

abstract class LogoutRemoteDataSource {
  Future<Either<Failure, LogoutResponseEntity>> logout();
}
