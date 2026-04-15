import 'package:tasky_api/features/auth/data/models/refresh_token_response_dto.dart';
import 'package:tasky_api/features/auth/domain/entities/refresh_token_response_entity.dart';

extension RefreshTokenResponseMapper on RefreshTokenResponseDto{
  RefreshTokenResponseEntity toEntity() {
    return RefreshTokenResponseEntity(
      accessToken: accessToken,
    );
  }
}