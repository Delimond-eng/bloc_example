import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stm_bloc/bloc/todo/todo_bloc.dart';
import 'package:stm_bloc/bloc/todo_filter/todos_filter_bloc.dart';
import 'package:stm_bloc/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>TodoBloc()..add(const LoadTodos())),
        BlocProvider(create: (context)=> TodosFilterBloc(todoBloc: BlocProvider.of(context)))
      ],
      child: MaterialApp(
        title: 'Bloc Pattern for Business Logic',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            primaryColor: const Color(0xFF000A1F),
            appBarTheme: const AppBarTheme(color: Color(0xFF000A1F))),
        home: const HomeScreen(),
      ),
    );
  }
}

/**
 * [
   * BlocProvider.of<TodosFilterBloc>(context).add(
   *   const UpdateTodos(
   *     todosFilter:TodosFilter.pending
   *   )
   * )
 * ]
 * **/
