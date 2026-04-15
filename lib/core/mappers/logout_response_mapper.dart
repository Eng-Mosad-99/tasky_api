import 'package:tasky_api/features/auth/data/models/logout_response_dto.dart';

import '../../features/auth/domain/entities/logout_response_entity.dart';

extension LogoutResponseMapper on LogoutResponseDto {
  LogoutResponseEntity toEntity() {
    return LogoutResponseEntity(
      success: success,
    );
  }
}