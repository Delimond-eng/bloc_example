import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/todo_filter_model.dart';
import '../../models/todo_model.dart';
import '../todo/todo_bloc.dart';

part 'todos_filter_event.dart';
part 'todos_filter_state.dart';

class TodosFilterBloc extends Bloc<TodosFilterEvent, TodosFilterState> {
  final TodoBloc _todoBloc;
  late StreamSubscription _todoSubscription;
  TodosFilterBloc({required TodoBloc todoBloc}) : _todoBloc = todoBloc, super(TodosFilterLoading()) {
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateTodos>(_onUpdateTodos);


    _todoSubscription = todoBloc.stream.listen((event) {
      add(const UpdateTodos());
    });
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<TodosFilterState> emit){
    if(state is TodosFilterLoading){
      add(
        const UpdateTodos(todosFilter: TodosFilter.pending),
      );
    }

    if(state is TodosFilterLoaded){
      final state = this.state as TodosFilterLoaded;
      add(
         UpdateTodos(todosFilter: state.todosFilter),
      );
    }
  }

  void _onUpdateTodos(UpdateTodos event, Emitter<TodosFilterState> emit){
    final state = _todoBloc.state;
    if(state is TodoLoaded){
      List<Todo> todos = state.todos.where((todo){
        switch(event.todosFilter){
          case TodosFilter.all:
            return true;
          case TodosFilter.completed:
            return todo.isCompleted!;
          case TodosFilter.cancelled:
            return todo.isCancelled!;
          case TodosFilter.pending:
            return !(todo.isCancelled! || todo.isCompleted!);
        }
      }).toList();
    }
  }
}
