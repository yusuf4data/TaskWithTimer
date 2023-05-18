import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orginizer/logic/cubit/task_cubit.dart';
import 'package:my_orginizer/models/task.dart';
import 'package:uuid/uuid.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({super.key});
  TextEditingController timeController = TextEditingController();

  TextEditingController taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 100,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                    width: 150,
                    child: TextField(
                      autofocus: true,
                      controller: taskController,
                    )),
                SizedBox(
                    width: 100,
                    child: TextField(
                        decoration:
                            const InputDecoration(hintText: 'timer in min'),
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
                        taskController.text = 'blk time';
                      }
                      if (timeController.text == '') {
                        //   if (timeRemaining > 30) {
                        timeController.text = '25';
             
                      }

                      {
                        var tasktimer = int.parse(timeController.text);
                        var totalTimer = tasktimer + (tasktimer / 5).round();
                        BlocProvider.of<TaskCubit>(context).addTask(Task(
                            id: const Uuid().v4(),
                            title: taskController.text,
                            period: int.parse(timeController.text)));

                    
                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Save')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
