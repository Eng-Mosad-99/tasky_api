class RegisterRequestBody {
 final String phone;
 final String password;
 final String displayName;
 final int experienceYears;
 final String address;
 final String level;
 
  RegisterRequestBody({
    required this.phone,
    required this.password,
    required this.displayName,
    required this.experienceYears,
    required this.address,
    required this.level,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['displayName'] = displayName;
    data['experienceYears'] = experienceYears;
    data['address'] = address;
    data['level'] = level;
    return data;
  }
}

