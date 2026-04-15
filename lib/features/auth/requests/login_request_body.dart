class LoginRequestBody {
  final String phone;
  final String password;

  LoginRequestBody({required this.phone, required this.password});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}
