class RegisterResponseDto {
  String? sId;
  String? displayName;
  String? accessToken;
  String? refreshToken;
 String? message;
  RegisterResponseDto(
      {this.sId, this.displayName, this.accessToken, this.refreshToken , this.message});

  RegisterResponseDto.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    displayName = json['displayName'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['displayName'] = displayName;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['message'] = message;
    return data;
  }
}