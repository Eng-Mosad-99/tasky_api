import 'package:tasky_api/features/home/data/models/create_todo_response_dto.dart';
import 'package:tasky_api/features/home/domain/entities/create_todo_response_entity.dart';

extension CreateTodoResponseMapper on CreateTodoResponseDto {
  CreateTodoResponseEntity toEntity() {
    return CreateTodoResponseEntity(
      image: image,
      title: title,
      desc: desc,
      priority: priority,
      status: status,
      user: user,
      sId: sId,
      createdAt: createdAt,
      updatedAt: updatedAt,
      iV: iV,
    );
  }
}