class LoginResponseEntity {
  String? sId;
  String? accessToken;
  String? refreshToken;

  LoginResponseEntity({
    required this.sId,
    required this.accessToken,
    required this.refreshToken,
  });
}
