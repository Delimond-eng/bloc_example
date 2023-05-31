import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stm_bloc/bloc/todo/todo_bloc.dart';

import '../models/todo_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc Pattern Todo List"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        /*Bloc builder permet de recuperer l'etat d'un bloc specifique*/
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            if (state is TodoLoading) {
              return const CircularProgressIndicator();
            }
            if (state is TodoLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) => todoCard(
                      context,
                      state.todos[index],
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoModal(context),
        child: const Icon(CupertinoIcons.add),
      ),
    );
  }

  Widget todoCard(BuildContext context, Todo todo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.task,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text(
                  todo.description,
                  style: const TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<TodoBloc>().add(DeleteTodo(todo: todo));
                  },
                  icon: const Icon(Icons.clear_rounded),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  /*Ce modal permet d'ajouter une nouvelle tache */
  void _showAddTodoModal(BuildContext ctx) {
    var size = MediaQuery.of(ctx).size;
    var taskController = TextEditingController();
    var descController = TextEditingController();

    showGeneralDialog(
      context: ctx,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        Tween<Offset> tween;
        tween = Tween(begin: const Offset(1, 0), end: Offset.zero);
        return SlideTransition(
          position: tween.animate(
            CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          ),
          child: child,
        );
      },
      pageBuilder: (context, __, _) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SingleChildScrollView(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10.0),
                    padding: const EdgeInsets.all(20.0),
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.zero,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(.3),
                          blurRadius: 10,
                          offset: const Offset(0, -3),
                        )
                      ],
                    ),
                    /*Le BlocListener permet d'écouter le changement d'un Etat*/
                    child: BlocListener<TodoBloc, TodoState>(
                      listener: (context, state) {
                        if (state is TodoLoaded) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Todo is added !")));
                        }
                      },
                      child: Column(
                        children: [
                          inputField(
                            controller: taskController,
                            title: "Task title",
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          inputField(
                            controller: descController,
                            title: "Description...",
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          /*Ce bloc builder va juste me permettre de recuperer l'état de ma liste et effectuer des taches dessus !*/
                          BlocBuilder<TodoBloc, TodoState>(
                              builder: (context, state) {
                            return SizedBox(
                              width: size.width,
                              child: ElevatedButton(
                                onPressed: () {
                                  int todoId = 0;
                                  if (state is TodoLoaded) {
                                    if (state.todos.isNotEmpty) {
                                      todoId = (state.todos.last.id! + 1);
                                      print(todoId);
                                    }
                                  }
                                  var todo = Todo(
                                    id: todoId,
                                    task: taskController.text,
                                    description: descController.text,
                                  );
                                  context.read<TodoBloc>().add(
                                        AddTodo(todo: todo),
                                      );
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  padding: const EdgeInsets.all(15.0),
                                ),
                                child: const Text(
                                  "Add new task",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget inputField({String? title, TextEditingController? controller}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: title,
        label: Text(title!),
      ),
    );
  }
}
