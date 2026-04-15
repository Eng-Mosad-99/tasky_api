import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/todos_response_entity.dart';
import '../repositories/todos_repository.dart';

class TodosUseCase {
  final TodosRepository todosRepository;

  TodosUseCase({required this.todosRepository});

  Future<Either<Failure, List<TodosResponseEntity>>> call() async =>
      await todosRepository.getAllTodos();
}
