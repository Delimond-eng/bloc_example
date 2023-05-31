import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

/*Bloc central qui permet de gerer les evenements et les etats sur les données */
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoLoading()) {
    on<LoadTodos>(
        _onLoadTodos); /*Lorsque l'evenement [chargement] est declenché*/
    on<AddTodo>(_onAddTodo); /*Lorsque l'evenement [ajout] est declenché*/
    on<DeleteTodo>(
        _onDeleteTodo); /*Lorsque l'evenement [suppression] est declenché*/
    on<UpdateTodo>(
        _onUpdateTodo); /*Lorsque l'evenement [modification] est declenché*/
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      emit(
        TodoLoaded(
          todos: List.from(state.todos)..add(event.todo),
        ),
      );
    }
  }

  void _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = state.todos.where((todo) {
        return todo.id != event.todo.id;
      }).toList();
      /*emit: permet d'appeler un evenement existant dans un autre evenement*/
      emit(
        TodoLoaded(todos: todos),
      );
    }
  }

  void _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) {
    final state = this.state;
    if (state is TodoLoaded) {
      List<Todo> todos = state.todos.map((todo) {
        return todo.id == event.todo.id ? event.todo : todo;
      }).toList();
      emit(
        TodoLoaded(todos: todos),
      );
    }
  }
}
