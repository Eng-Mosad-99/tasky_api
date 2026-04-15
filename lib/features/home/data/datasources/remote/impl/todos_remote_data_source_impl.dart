import 'package:dartz/dartz.dart';
import 'package:tasky_api/core/api/api.dart';
import 'package:tasky_api/core/api/end_points.dart';
import 'package:tasky_api/core/errors/failures.dart';
import 'package:tasky_api/core/mappers/create_todo_response_mapper.dart';
import 'package:tasky_api/core/mappers/todos_response_mapper.dart';
import 'package:tasky_api/core/mappers/upload_image_response_mapper.dart';
import 'package:tasky_api/core/network/network_service.dart';
import 'package:tasky_api/features/home/data/datasources/remote/todos_remote_data_source.dart';
import 'package:tasky_api/features/home/data/models/todos_response_dto.dart';
import 'package:tasky_api/features/home/domain/entities/create_todo_response_entity.dart';
import 'package:tasky_api/features/home/domain/entities/todos_response_entity.dart';
import 'package:tasky_api/features/home/domain/entities/upload_image_response_entity.dart';
import 'package:tasky_api/features/home/requests/create_todo_request_body.dart';

import '../../../models/create_todo_response_dto.dart';
import '../../../models/upload_image_response_dto.dart';

class TodosRemoteDataSourceImpl implements TodosRemoteDataSource {
  final API api;
  final NetworkService networkService;

  TodosRemoteDataSourceImpl({required this.api, required this.networkService});
  @override
  Future<Either<Failure, List<TodosResponseEntity>>> getAllTodos() async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.get(EndPoints.getAllTodos);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          final List<TodosResponseDto> todosResponseDto =
              (response.data as List)
                  .map((e) => TodosResponseDto.fromJson(e))
                  .toList();
          return Right(todosResponseDto.map((e) => e.toEntity()).toList());
        } else {
          return Left(
            ServerFailure(response.data['message'] ?? 'An error occurred'),
          );
        }
      } else {
        return Left(ServerFailure('No Internet Connection'));
      }
    } catch (e) {
      print(e);
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, TodosResponseEntity>> getOneTodo(String todoID) async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.get("${EndPoints.getAllTodos}/$todoID");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return right(TodosResponseDto.fromJson(response.data).toEntity());
        } else {
          return Left(
            ServerFailure(response.data['message'] ?? 'An error occurred'),
          );
        }
      } else {
        return Left(ServerFailure('No Internet Connection'));
      }
    } catch (e) {
      print(e);
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UploadImageResponseEntity>> uploadTodoImage(
    String filePath,
  ) async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.uploadFile(filePath: filePath);
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return right(
            UploadImageResponseDto.fromJson(response.data).toEntity(),
          );
        } else {
          return Left(
            ServerFailure(response.data['message'] ?? 'An error occurred'),
          );
        }
      } else {
        return Left(ServerFailure('No Internet Connection'));
      }
    } catch (e) {
      print(e);
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CreateTodoResponseEntity>> createTodo(
    CreateTodoRequestBody createTodoRequestBody,
  ) async {
    try {
      if (await networkService.isConnected()) {
        final response = await api.post(
          EndPoints.createTodo,
          data: createTodoRequestBody.toJson(),
        );
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return right(
            CreateTodoResponseDto.fromJson(response.data).toEntity(),
          );
        } else {
          return Left(
            ServerFailure(response.data['message'] ?? 'An error occurred'),
          );
        }
      } else {
        return Left(ServerFailure('No Internet Connection'));
      }
    } catch (e) {
      print(e);
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, CreateTodoResponseEntity>> deleteTodo(String todoID)async {
     try {
      if (await networkService.isConnected()) {
        final response = await api.delete("${EndPoints.getAllTodos}/$todoID");
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          return right(CreateTodoResponseDto.fromJson(response.data).toEntity());
        } else {
          return Left(
            ServerFailure(response.data['message'] ?? 'An error occurred'),
          );
        }
      } else {
        return Left(ServerFailure('No Internet Connection'));
      }
    } catch (e) {
      print(e);
      if (e is ServerFailure) {
        return Left(e);
      }
      return Left(ServerFailure(e.toString()));
    }
  }
}
