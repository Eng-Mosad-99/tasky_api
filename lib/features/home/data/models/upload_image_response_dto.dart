class UploadImageResponseDto {
  String? image;

  UploadImageResponseDto({this.image});

  UploadImageResponseDto.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    return data;
  }
}