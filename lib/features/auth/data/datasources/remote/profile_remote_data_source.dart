import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/profile_response_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<Either<Failure, ProfileResponseEntity>> getProfile();
}
