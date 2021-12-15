import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_node/models/todo_model.dart';
import 'package:flutter_node/pages/bloc/todos_bloc.dart';

class UpdateScreenPage extends StatefulWidget {
  final TodoModel todo;
  final void Function() refreshFn;

  const UpdateScreenPage({required this.todo, required this.refreshFn, Key? key}) : super(key: key);

  @override
  _UpdateScreenPageState createState() => _UpdateScreenPageState();
}

class _UpdateScreenPageState extends State<UpdateScreenPage> {
  TodosBloc bloc = TodosBloc();
  TextEditingController descController = TextEditingController();
  @override
  void initState() {
    super.initState();
    descController.text = widget.todo.description;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosBloc, TodosState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TodosUpdateLoadingState) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Lütfen Bekleyin'),
              content: const Text('Düzenleniyor.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Tamam'),
                  child: const Text('Tamam'),
                ),
              ],
            ),
          );
        } else if (state is TodosUpdateLoadedState) {
          Navigator.pop(context);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Başarılı'),
              content: const Text('Düzenlendi.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Tamam'),
                  child: const Text('Tamam'),
                ),
              ],
            ),
          );
          widget.refreshFn();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Düzenle"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Açıklama"),
                ),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(
                      TodosUpdateEvent(
                        TodoModel(todoId: widget.todo.todoId, description: descController.text),
                      ),
                    );
                  },
                  child: const Text("Düzenle"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
