import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/home/domain/entities/upload_image_response_entity.dart';

import '../repositories/todos_repository.dart';

class UploadTodoImageUseCase {
  final TodosRepository todosRepository;

  UploadTodoImageUseCase({required this.todosRepository});

  Future<Either<Failure, UploadImageResponseEntity>> call(
    String imagePath,
  ) async => await todosRepository.uploadTodoImage(imagePath);
}
