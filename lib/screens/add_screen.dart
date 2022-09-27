import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stm_bloc/bloc/todo/todo_bloc.dart';

import '../models/todo_model.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerTask = TextEditingController();
    TextEditingController controllerDesc = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Task"),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        listener: (context, state){
            if(state is TodoLoaded){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Todo is added !"))
              );
            }
        },
        child: Card(
          child: Column(
            children: [
              inputField("Id", controllerId),
              inputField("Task", controllerTask),
              inputField("Description", controllerDesc),
              ElevatedButton(
                onPressed: () {
                  var todo = Todo(
                    id:controllerId.value.text,
                    task: controllerTask.value.text,
                    description: controllerDesc.value.text,
                  );
                  context.read<TodoBloc>().add(AddTodo(todo: todo));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(10.0),
                ),
                child: const Text(
                  "Add new",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget inputField(String title, TextEditingController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          '$title :',
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w700),
        ),
        Container(
          height: 50.0,
          margin: const EdgeInsets.only(bottom: 10.0),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
          ),
        )
      ],
    );
  }
}
