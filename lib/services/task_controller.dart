import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orginizer/logic/cubit/task_cubit.dart';
import 'package:my_orginizer/models/task.dart';
import 'package:my_orginizer/widget/edit_task.dart';
import 'package:uuid/uuid.dart';

class TaskController {
  BuildContext context;
  TaskController({
    required this.context,
  });

  void doubleThisTask(Task task, int index) {
    BlocProvider.of<TaskCubit>(context)
        .doubleThisTask(task.copyWith(id: const Uuid().v4()), index + 1);
  }

  updateMyTaskOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    BlocProvider.of<TaskCubit>(context)
        .reorderTask(oldIndex: oldIndex, newIndex: newIndex);
  }

  void deleteTask(int index) {
    BlocProvider.of<TaskCubit>(context).delete(index);
  }
}

void editTask(BuildContext context, Task task) {
  showDialog(
    context: context,
    builder: (context) {
      return EditTask(task: task);
    },
  );
}
