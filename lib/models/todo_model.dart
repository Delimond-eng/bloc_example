import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  int? id;
  final String task;
  final String description;

  Todo({
    this.id,
    required this.task,
    required this.description,
  });

  Todo copyWith({
    int? id,
    String? task,
    String? description,
    bool? isCompleted,
    bool? isCancelled,
  }) {
    return Todo(
      id: id ?? this.id,
      task: task ?? this.task,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
      ];
}
