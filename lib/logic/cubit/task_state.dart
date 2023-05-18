part of 'task_cubit.dart';

class TaskState extends Equatable {
  //final Task task;
  final List<Task> tasks;
  //final DateTime endSession = DateTime.now();
  const TaskState({
    this.tasks = const <Task>[],
  });

  @override
  List<Object?> get props => [tasks];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'tasks': tasks.map((x) => x.toMap()).toList()});

    return result;
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      tasks: List<Task>.from(map['tasks']?.map((x) => Task.fromMap(x))),
    );
  }
}
