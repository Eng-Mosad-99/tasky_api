import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/home/domain/entities/create_todo_response_entity.dart';
import 'package:tasky_api/features/home/domain/repositories/todos_repository.dart';
import 'package:tasky_api/features/home/requests/create_todo_request_body.dart';

class CreateTodoUseCase {
  final TodosRepository todosRepository;
  CreateTodoUseCase(this.todosRepository);

  Future<Either<Failure, CreateTodoResponseEntity>> call(
    CreateTodoRequestBody createTodoRequestBody,
  ) async => await todosRepository.createTodo(createTodoRequestBody);
}
