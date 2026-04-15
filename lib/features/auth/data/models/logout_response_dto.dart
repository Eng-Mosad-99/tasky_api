class LogoutResponseDto {
  final bool success;

  LogoutResponseDto(this.success);

  LogoutResponseDto.fromJson(Map<String, dynamic> json)
    : success = json['success'];

  Map<String, dynamic> toJson() => {'success': success};
}
