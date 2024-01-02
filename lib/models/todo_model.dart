class Todo {
  String? id;
  String? type;
  String? title;

  String? startAt;
  String? endAt;

  Todo({
    this.id,
    this.type,
    this.title,
    this.startAt,
    this.endAt,
  });

  Todo.fromJson(Map<String, dynamic> json, String idTodo) {
    id = idTodo;
    type = json['type'];
    title = json['title'];
    startAt = json['startAt'];
    endAt = json['endAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['title'] = title;
    data['startAt'] = startAt;
    data['endAt'] = endAt;

    return data;
  }
}
