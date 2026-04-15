class CreateTodoRequestBody {
  final String image;
  final String title;
  final String desc;
  final String priority;
  final String dueDate;

  CreateTodoRequestBody({
    required this.image,
    required this.title,
    required this.desc,
    required this.priority,
    required this.dueDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['title'] = title;
    data['desc'] = desc;
    data['priority'] = priority;
    data['dueDate'] = dueDate;
    return data;
  }
}
