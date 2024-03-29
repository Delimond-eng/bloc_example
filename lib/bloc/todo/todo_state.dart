part of 'todo_bloc.dart';

/*TodoBloc [state] permet de recuperer l'etat de notre bloc {todo}*/

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  const TodoLoaded({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}
