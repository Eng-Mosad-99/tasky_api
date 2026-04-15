class LoginResponseDto {
  String? sId;

  String? accessToken;
  String? refreshToken;

  LoginResponseDto({this.sId, this.accessToken, this.refreshToken});

  LoginResponseDto.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];

    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;

    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;

    return data;
  }
}
