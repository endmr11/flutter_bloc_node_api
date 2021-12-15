part of 'todos_bloc.dart';

abstract class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

class TodosInitialState extends TodosState {}

class TodosLoadingState extends TodosState {}

class TodosLoadedState extends TodosState {
  final List<TodoModel> todos;
  const TodosLoadedState({required this.todos});
  @override
  List<Object> get props => [todos];
}

class TodosCreateLoadingState extends TodosState {}

class TodosCreateLoadedState extends TodosState {}

class TodosUpdateLoadingState extends TodosState {}

class TodosUpdateLoadedState extends TodosState {}

class TodosDeleteLoadingState extends TodosState {}

class TodosDeleteLoadedState extends TodosState {}
