import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/todos_response_entity.dart';
import '../repositories/todos_repository.dart';

class GetOneTodoUseCase {
  final TodosRepository todosRepository;

  GetOneTodoUseCase({required this.todosRepository});

  Future<Either<Failure, TodosResponseEntity>> call(String todoID) async =>
      await todosRepository.getOneTodo(todoID);
}
