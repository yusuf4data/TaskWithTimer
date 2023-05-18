import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_orginizer/logic/cubit/task_cubit.dart';
import 'package:my_orginizer/models/task.dart';

class EditTask extends StatefulWidget {
  Task task;
  EditTask({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController timeController = TextEditingController();

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    timeController.text = widget.task.period.toString();
    taskController.text = widget.task.title;
    return Dialog(
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 130,
                    child: TextField(
                      controller: taskController,
                    )),
                SizedBox(
                    width: 30,
                    child: TextField(
                        controller: timeController,
                        keyboardType: TextInputType.number))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (taskController.text == '') {
                        taskController.text = 'blk edited';
                      }
                      if (timeController.text == '') {
                        timeController.text = widget.task.period.toString();
                      }
                      var taskTimer = int.parse(timeController.text);

                      //timeRemaining - (taskTimer - task.period);
                      BlocProvider.of<TaskCubit>(context).edit(Task(
                          id: widget.task.id,
                          title: taskController.text,
                          period: int.parse(timeController.text)));
                      Navigator.pop(context);
                      // }
                    },
                    child: const Text('Edit')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
