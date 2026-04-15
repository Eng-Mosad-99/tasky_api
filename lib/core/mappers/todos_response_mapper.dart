import 'package:tasky_api/features/home/data/models/todos_response_dto.dart';

import '../../features/home/domain/entities/todos_response_entity.dart';

extension TodosResponseMapper on TodosResponseDto{
  TodosResponseEntity toEntity(){
    return TodosResponseEntity(
      sId: sId,
      title: title,
      image: image,
      desc: desc,
      priority: priority,
      status: status,
      user: user,
      createdAt: createdAt,
      updatedAt: updatedAt,
      iV: iV
    );
  }
}
