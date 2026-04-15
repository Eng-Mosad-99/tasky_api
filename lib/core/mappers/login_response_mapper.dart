import '../../features/auth/data/models/login_response_dto.dart';
import '../../features/auth/domain/entities/login_response_entity.dart';

extension LoginResponseMapper on LoginResponseDto {
  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      sId: sId,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}