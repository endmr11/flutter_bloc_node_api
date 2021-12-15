part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class TodosStartEvent extends TodosEvent {}

class TodoStartEvent extends TodosEvent {
  final int id;
  const TodoStartEvent(this.id);

  @override
  List<Object> get props => [id];
}

class TodosCreateEvent extends TodosEvent {
  final TodoModel todo;
  const TodosCreateEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodosUpdateEvent extends TodosEvent {
  final TodoModel todo;
  const TodosUpdateEvent(this.todo);
  @override
  List<Object> get props => [todo];
}

class TodosDeleteEvent extends TodosEvent {
  final TodoModel todo;
  const TodosDeleteEvent(this.todo);
  @override
  List<Object> get props => [todo];
}
