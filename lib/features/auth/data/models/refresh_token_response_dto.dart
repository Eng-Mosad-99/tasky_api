class RefreshTokenResponseDto {
  String? accessToken;

  RefreshTokenResponseDto({this.accessToken});

  RefreshTokenResponseDto.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    return data;
  }
}
