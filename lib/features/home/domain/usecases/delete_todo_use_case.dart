import 'package:dartz/dartz.dart';
import 'package:tasky_api/features/home/domain/repositories/todos_repository.dart';

import '../../../../core/errors/failures.dart';
import '../entities/create_todo_response_entity.dart';

class DeleteTodoUseCase {
  final TodosRepository todosRepository;
  DeleteTodoUseCase(this.todosRepository);

  Future<Either<Failure, CreateTodoResponseEntity>> call(
    String todoID,
  ) async => await todosRepository.deleteTodo(todoID);
}
