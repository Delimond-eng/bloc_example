part of 'todo_bloc.dart';

/*TodoBloc [Event] perment de creer des evenement où le comportement de notre bloc {todo} */
abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

/*Lors de chargement de données, cette evenement peut etre appelé sur un [etat]*/
class LoadTodos extends TodoEvent {
  final List<Todo> todos;

  const LoadTodos({this.todos = const <Todo>[]});

  @override
  List<Object> get props => [todos];
}

/*Permet d'ajouter une données */
class AddTodo extends TodoEvent {
  final Todo todo;
  const AddTodo({required this.todo});
  @override
  List<Object> get props => [todo];
}

/*Permet mettre à jour une données */
class UpdateTodo extends TodoEvent {
  final Todo todo;
  const UpdateTodo({required this.todo});
  @override
  List<Object> get props => [todo];
}

/*Permet efface une données */
class DeleteTodo extends TodoEvent {
  final Todo todo;
  const DeleteTodo({required this.todo});
  @override
  List<Object> get props => [todo];
}
