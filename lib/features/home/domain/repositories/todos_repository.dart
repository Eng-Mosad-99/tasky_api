import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/home/domain/entities/create_todo_response_entity.dart';
import 'package:tasky_api/features/home/domain/entities/upload_image_response_entity.dart';
import 'package:tasky_api/features/home/requests/create_todo_request_body.dart';

import '../entities/todos_response_entity.dart';

abstract class TodosRepository {
  Future<Either<Failure, List<TodosResponseEntity>>> getAllTodos();
  Future<Either<Failure, TodosResponseEntity>> getOneTodo(String todoID);
  Future<Either<Failure, CreateTodoResponseEntity>> deleteTodo(String todoID);
  Future<Either<Failure, UploadImageResponseEntity>> uploadTodoImage( String imagePath);
  Future<Either<Failure, CreateTodoResponseEntity>> createTodo( CreateTodoRequestBody createTodoRequestBody);
  
}
