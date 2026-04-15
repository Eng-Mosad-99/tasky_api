import 'package:tasky_api/features/auth/data/models/register_response_dto.dart';

import '../../features/auth/domain/entities/register_response_entity.dart';

extension RegisterResponseMapper on RegisterResponseDto {
  RegisterResponseEntity toEntity() {
    return RegisterResponseEntity(
      sId: sId,
 
      accessToken: accessToken,
      refreshToken: refreshToken,
      displayName: displayName,
    );
  }
}