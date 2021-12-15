import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_node/models/todo_model.dart';
import 'package:flutter_node/services/http_service.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitialState()) {
    on(todosEventControl);
  }

  Future<void> todosEventControl(TodosEvent event, Emitter<TodosState> emit) async {
    if (event is TodosStartEvent) {
      emit(TodosLoadingState());
      List<TodoModel> todos = [];
      await HttpServices().getAllTodos().then((value) {
        todos = value;
      });
      emit(TodosLoadedState(todos: todos));
    } else if (event is TodosCreateEvent) {
      emit(TodosCreateLoadingState());
      HttpServices().createTodo(event.todo);
      emit(TodosCreateLoadedState());
    } else if (event is TodosUpdateEvent) {
      emit(TodosUpdateLoadingState());
      HttpServices().updateTodo(event.todo);
      emit(TodosUpdateLoadedState());
    } else if (event is TodosDeleteEvent) {
      emit(TodosDeleteLoadingState());
      HttpServices().deleteTodo(event.todo);
      emit(TodosDeleteLoadedState());
    }
  }
}
