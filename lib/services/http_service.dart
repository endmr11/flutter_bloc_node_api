import 'dart:convert';

import 'package:flutter_node/models/todo_model.dart';
import 'package:http/http.dart' as http;

class HttpServices {
  Future<List<TodoModel>> getAllTodos() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:3000/todos"));
    var todosBody = jsonDecode(response.body);
    List<TodoModel> todos = [];
    for (var t in todosBody) {
      TodoModel todo = TodoModel(todoId: t['todo_id'], description: t['description']);
      todos.add(todo);
    }
    return todos;
  }

  void createTodo(TodoModel todo) async {
    var response = await http.post(Uri.parse("http://10.0.2.2:3000/todos"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"description": todo.description}));
    print(response.statusCode);
  }

  void updateTodo(TodoModel todo) async {
    var response = await http.put(Uri.parse("http://10.0.2.2:3000/todos/${todo.todoId}"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"description": todo.description}));
    print(response.statusCode);
  }

  void deleteTodo(TodoModel todo) async {
    var response = await http.delete(Uri.parse("http://10.0.2.2:3000/todos/${todo.todoId}"));
    print(response.statusCode);
  }
}
