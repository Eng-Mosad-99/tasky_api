import 'package:tasky_api/features/auth/domain/entities/profile_response_entity.dart';

import '../../features/auth/data/models/profile_response_dto.dart';

extension ProfileResponseMapper on ProfileResponseDto {
  ProfileResponseEntity toEntity() {
    return ProfileResponseEntity(
      sId: sId,
      displayName: displayName,
      username: username,
      active: active,
      address: address,
      experienceYears: experienceYears,
      level: level,
      createdAt: createdAt,
      updatedAt: updatedAt,
      iV: iV,
      roles: roles,
    );
  }
}
