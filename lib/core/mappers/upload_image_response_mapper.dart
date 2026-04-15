import '../../features/home/data/models/upload_image_response_dto.dart';
import '../../features/home/domain/entities/upload_image_response_entity.dart';

extension UploadImageResponseMapper on UploadImageResponseDto {
  UploadImageResponseEntity toEntity() => UploadImageResponseEntity(image: image);
}