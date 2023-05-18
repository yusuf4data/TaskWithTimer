import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orginizer/logic/cubit/task_cubit.dart';
import 'package:my_orginizer/models/task.dart';
import 'package:my_orginizer/widget/add_new_task.dart';
import 'package:my_orginizer/widget/edit_task.dart';
import 'package:uuid/uuid.dart';

class MyTasksPage extends StatefulWidget {
  const MyTasksPage({Key? key}) : super(key: key);

  @override
  _MyTasksPageState createState() => _MyTasksPageState();
}

class _MyTasksPageState extends State<MyTasksPage> {
  List<Task> allTasks = [];
  void addNewTaskCard() {
    showDialog(
      context: context,
      builder: (context) {
        return AddNewTask();
      },
    );
  }

  updateMyTaskOrder(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex--;
      }
      BlocProvider.of<TaskCubit>(context)
          .reorderTask(oldIndex: oldIndex, newIndex: newIndex);
    });
  }

  void deleteTask(int index) {
    setState(() {
      BlocProvider.of<TaskCubit>(context).delete(index);
    });
  }

  void doubleThisTask(Task task, int index) {
    BlocProvider.of<TaskCubit>(context)
        .doubleThisTask(task.copyWith(id: const Uuid().v4()), index + 1);
  }

  void editTask(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) {
        return EditTask(task: task);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks in future'),
      ),
      body: SafeArea(
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            allTasks = state.tasks.where((task) => task.period == 0).toList();

            return Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton(
                    onPressed: () {
                      addNewTaskCard();
                    },
                    child: const Text('Add task with timer')),
                Expanded(
                    child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) =>
                      updateMyTaskOrder(oldIndex, newIndex),
                  itemCount: allTasks.length,
                  itemBuilder: (context, index) {
                    int accumalatedTime = allTasks[index].period +
                        (allTasks[index].period / 5).round();

                    return Dismissible(
                      onDismissed: (direction) {
                        deleteTask(index);
                      },
                      key: Key(allTasks[index].id),
                      child: GestureDetector(
                          onDoubleTap: () {
                            doubleThisTask(allTasks[index], index);
                          },
                          onTap: () {
                            // EditTask(task: state.tasks[index]);
                            editTask(context, allTasks[index]);
                          },
                          child: Column(
                            children: [
                              myTaskCard(allTasks[index], index,
                                  allTasks.length, size),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [],
                              ),
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

  Card myTaskCard(
    Task task,
    int currentIndex,
    int maxIndex,
    Size size,
  ) {
    var restTime = (task.period / 5).round();

    // timeRemaining = timeRemaining - taskTotalTime;

    return Card(
      // color: const Color.fromARGB(255, 212, 219, 225),
      child: SizedBox(
        height: size.height * .15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: Text(
                '$currentIndex - ${task.title}',
                textAlign: TextAlign.start,
                maxLines: 4, // justify,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => updateMyTaskOrder(currentIndex, 0),
                  icon: Icon(
                    Icons.arrow_drop_up_outlined,
                    size: size.height * .045,
                  ),
                ),
                IconButton(
                  onPressed: () => updateMyTaskOrder(currentIndex, maxIndex),
                  icon: Icon(
                    Icons.arrow_drop_down_sharp,
                    size: size.height * .045,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
