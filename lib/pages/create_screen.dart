import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_node/models/todo_model.dart';
import 'package:flutter_node/pages/bloc/todos_bloc.dart';

class CreateScreenPage extends StatefulWidget {
  final void Function() refreshFn;

  const CreateScreenPage({required this.refreshFn, Key? key}) : super(key: key);

  @override
  _CreateScreenPageState createState() => _CreateScreenPageState();
}

class _CreateScreenPageState extends State<CreateScreenPage> {
  TodosBloc bloc = TodosBloc();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosBloc, TodosState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is TodosCreateLoadingState) {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Please Wait'),
              content: const Text('Creating.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Okay'),
                  child: const Text('Okay'),
                ),
              ],
            ),
          );
        } else if (state is TodosCreateLoadedState) {
          Navigator.pop(context);
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const Text('Success'),
              content: const Text('Created.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Okay'),
                  child: const Text('Okay'),
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
            title: const Text("Create"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Description"),
                ),
                ElevatedButton(
                  onPressed: () {
                    bloc.add(
                      TodosCreateEvent(
                        TodoModel(todoId: 0, description: descController.text),
                      ),
                    );
                  },
                  child: const Text("Create"),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
