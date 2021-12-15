import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_node/models/todo_model.dart';
import 'package:flutter_node/pages/create_screen.dart';
import 'package:flutter_node/pages/update_screen.dart';

import 'bloc/todos_bloc.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  TodosBloc bloc = TodosBloc();
  var loaded = false;
  List<TodoModel>? todos;
  @override
  void initState() {
    super.initState();
    bloc.add(TodosStartEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodosBloc(),
      child: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is TodosLoadingState) {
            setState(() {
              loaded = false;
            });
          } else if (state is TodosLoadedState) {
            todos = state.todos;
            setState(() {
              loaded = true;
            });
          } else if (state is TodosDeleteLoadingState) {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Lütfen Bekleyin'),
                content: const Text('Siliniyor.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Tamam'),
                    child: const Text('Tamam'),
                  ),
                ],
              ),
            );
          } else if (state is TodosDeleteLoadedState) {
            Navigator.pop(context);
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Başarılı'),
                content: const Text('Silindi.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Tamam'),
                    child: const Text('Tamam'),
                  ),
                ],
              ),
            );
            bloc.add(TodosStartEvent());
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("TODO"),
          ),
          body: loaded
              ? ListView.builder(
                  itemCount: todos!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateScreenPage(
                              todo: todos![index],
                              refreshFn: () {
                                bloc.add(TodosStartEvent());
                              },
                            ),
                          ),
                        );
                      },
                      title: Text(todos![index].description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          bloc.add(
                            TodosDeleteEvent(todos![index]),
                          );
                        },
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateScreenPage(
                    refreshFn: () {
                      bloc.add(TodosStartEvent());
                    },
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
