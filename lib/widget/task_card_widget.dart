import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:my_orginizer/models/task.dart';
import 'package:my_orginizer/services/task_controller.dart';
import 'package:my_orginizer/widget/custom_show_case.dart';

class TaskCardWidget extends StatelessWidget {
  const TaskCardWidget({
    super.key,
    required GlobalKey<State<StatefulWidget>> four,
    required this.task,
    required this.currentIndex,
    required this.maxIndex,
    required this.size,
    required this.taskController,
  }) : _four = four;

  final GlobalKey<State<StatefulWidget>> _four;
  final Task task;
  final int currentIndex;
  final int maxIndex;
  final Size size;
  final TaskController taskController;

  @override
  Widget build(BuildContext context) {
    var restTime = (task.period / 5).round();
    return Card(
      // color: const Color.fromARGB(255, 212, 219, 225),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(100)),
        width: double.infinity,
        height: size.width > size.height ? size.height * .2 : size.height * .13,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width * 0.2,
              child: currentIndex == 0
                  ? CustomShowCase(
                      description: 'one tap to edit , double tap to duplicate',
                      globalkey: _four,
                      child: Text(
                        '${currentIndex + 1} - ${task.title}',
                        textAlign: TextAlign.start,
                        maxLines: 4, // justify,
                      ),
                    )
                  : Text(
                      '${currentIndex + 1} - ${task.title}',
                      textAlign: TextAlign.start,
                      maxLines: 4, // justify,
                    ),
            ),
            Text('${task.period}'),
            const Text('m'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      FlutterAlarmClock.createTimer(task.period * 60,
                          title: task.title);
                    },
                    child: const Icon(Icons.play_arrow)),
                const Text('task', style: TextStyle(color: Colors.blue))
              ],
            ),
            Text('$restTime'),
            const Text('m'),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      var restTimer = (task.period / 5).round();
                      FlutterAlarmClock.createTimer(restTimer * 60,
                          title: 'Rest time');
                    },
                    child: const Icon(Icons.play_arrow)),
                const Text('rest', style: TextStyle(color: Colors.blue))
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(
                  fit: FlexFit.loose,
                  child: IconButton(
                    onPressed: () =>
                        taskController.updateMyTaskOrder(currentIndex, 0),
                    icon: Icon(
                      Icons.arrow_drop_up_outlined,
                      size: size.height * .04,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: IconButton(
                    onPressed: () => taskController.updateMyTaskOrder(
                        currentIndex, maxIndex),
                    icon: Icon(
                      Icons.arrow_drop_down_sharp,
                      size: size.height * .04,
                    ),
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
