import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../models/task.dart';

part 'task_state.dart';

class TaskCubit extends HydratedCubit<TaskState> {
  TaskCubit() : super(const TaskState());

  void getAllTasks() {
    final state = this.state;
    //final tasks = this.state.tasks;
    emit(TaskState(tasks: state.tasks));
  }

  void edit(Task task) {
    final state = this.state;
    int index = state.tasks.indexWhere((element) => element.id == task.id);
    state.tasks.removeAt(index);
    emit(TaskState(tasks: List.from(state.tasks)..insert(index, task)));
  }

  void reorderTask({required int oldIndex, required int newIndex}) {
    final task = state.tasks[oldIndex];
    state.tasks.removeAt(oldIndex);
    emit(TaskState(tasks: List.from(state.tasks)..insert(newIndex, task)));
  }

  void delete(int index) {
    emit(TaskState(tasks: List.from(state.tasks)..removeAt(index)));
  }

  void deleteAll() {
    emit(TaskState(
        tasks: List.from(state.tasks)..removeRange(0, state.tasks.length)));
  }

  void addTask(Task task) {
    final state = this.state;

    emit(TaskState(tasks: List.from(state.tasks)..add(task)));
  }

  void doubleThisTask(Task task, int index) {
    final state = this.state;

    emit(TaskState(tasks: List.from(state.tasks)..insert(index, task)));
  }

  int getTotalTimers() {
    var totalTimers = state.tasks.fold(
        10,
        (previousValue, element) =>
            previousValue + (element.period * 6 / 5).round());
    return totalTimers;
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }
}
