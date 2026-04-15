import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/auth/domain/entities/logout_response_entity.dart';

import '../repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;

  LogoutUseCase({required this.repository});

  Future<Either<Failure, LogoutResponseEntity>> call() async {
    return await repository.logout();
  }
}
