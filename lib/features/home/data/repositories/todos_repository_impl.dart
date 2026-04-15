import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/features/home/data/datasources/remote/todos_remote_data_source.dart';
import 'package:tasky_api/features/home/domain/entities/create_todo_response_entity.dart';
import 'package:tasky_api/features/home/domain/entities/todos_response_entity.dart';
import 'package:tasky_api/features/home/domain/entities/upload_image_response_entity.dart';
import 'package:tasky_api/features/home/domain/repositories/todos_repository.dart';
import 'package:tasky_api/features/home/requests/create_todo_request_body.dart';

class TodosRepositoryImpl implements TodosRepository {
  final TodosRemoteDataSource todosRemoteDataSource;

  TodosRepositoryImpl({required this.todosRemoteDataSource});
  @override
  Future<Either<Failure, List<TodosResponseEntity>>> getAllTodos() async {
    return await todosRemoteDataSource.getAllTodos();
  }

  @override
  Future<Either<Failure, TodosResponseEntity>> getOneTodo(String todoID) async {
    return await todosRemoteDataSource.getOneTodo(todoID);
  }

  @override
  Future<Either<Failure, UploadImageResponseEntity>> uploadTodoImage(
    String imagePath,
  ) async {
    return await todosRemoteDataSource.uploadTodoImage(imagePath);
  }

  @override
  Future<Either<Failure, CreateTodoResponseEntity>> createTodo(
    CreateTodoRequestBody createTodoRequestBody,
  ) async {
    return await todosRemoteDataSource.createTodo(createTodoRequestBody);
  }
  
  @override
  Future<Either<Failure, CreateTodoResponseEntity>> deleteTodo(String todoID) async{
    return await todosRemoteDataSource.deleteTodo(todoID);
  }
}
