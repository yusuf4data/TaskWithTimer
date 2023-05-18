import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/task_cubit.dart';
import '../models/task.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> allTasks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            allTasks = state.tasks;

            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) =>
                      updateMyTaskOrder(oldIndex, newIndex),
                  itemCount: state.tasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      onDismissed: (direction) {
                        // deleteTask(index);
                      },
                      key: Key(state.tasks[index].id),
                      child: GestureDetector(
                          onTap: () {
                            //  editTask(context, state.tasks[index]);
                          },
                          child: Column(
                            children: [
                              Card(child: Text(state.tasks[index].title)),
                            ],
                          )),
                    );
                  },
                )),
                if (allTasks.isNotEmpty)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          BlocProvider.of<TaskCubit>(context).deleteAll();
                        });
                      },
                      child: const Text('Delete all tasks')),
              ],
            );
          },
        ),
      ),
    );
  }

  updateMyTaskOrder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    BlocProvider.of<TaskCubit>(context)
        .reorderTask(oldIndex: oldIndex, newIndex: newIndex);
  }
}
