class CreateTodoResponseDto {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  CreateTodoResponseDto(
      {this.image,
      this.title,
      this.desc,
      this.priority,
      this.status,
      this.user,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.iV});

  CreateTodoResponseDto.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    desc = json['desc'];
    priority = json['priority'];
    status = json['status'];
    user = json['user'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['desc'] = desc;
    data['priority'] = priority;
    data['status'] = status;
    data['user'] = user;
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}