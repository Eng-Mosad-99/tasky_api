import 'package:dartz/dartz.dart';
import 'package:tasky_api/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/refresh_token_response_entity.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase({required this.repository});

  Future<Either<Failure, RefreshTokenResponseEntity>> call() async {
    return await repository.refreshToken();
  }
}
