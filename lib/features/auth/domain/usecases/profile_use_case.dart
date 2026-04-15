import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/profile_response_entity.dart';
import '../repositories/auth_repository.dart';

class ProfileUseCase {
  final AuthRepository repository;

  ProfileUseCase({required this.repository});

  Future<Either<Failure, ProfileResponseEntity>> call() async {
    return await repository.getProfile();
  }
}
