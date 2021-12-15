import 'dart:convert';

List<TodoModel> todoModelFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodoModel {
  TodoModel({
    required this.todoId,
    required this.description,
  });

  int todoId;
  String description;

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        todoId: json["todo_id"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "todo_id": todoId,
        "description": description,
      };
}
