import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_orginizer/services/task_controller.dart';
import 'package:my_orginizer/widget/add_new_task.dart';
import 'package:my_orginizer/widget/custom_show_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showcaseview/showcaseview.dart';

import 'package:my_orginizer/logic/cubit/task_cubit.dart';
import 'package:my_orginizer/models/session.dart';
import 'package:my_orginizer/models/task.dart';
import 'package:my_orginizer/widget/top_title.dart';

import 'widget/task_card_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey _one = GlobalKey();
  final GlobalKey _two = GlobalKey();
  final GlobalKey _three = GlobalKey();
  final GlobalKey _four = GlobalKey();
  final GlobalKey _five = GlobalKey();
  final GlobalKey _six = GlobalKey();
  int counter = 0;
  int timerInSeconds = 0;
  late Session session;
  late DateTime _timeAttheBegining;
  late DateTime _timeAttheEnd;
  DateTime? timeAtStartedTimer;
  TaskCubit taskCubit = TaskCubit();

  var timeRemaining = 0;
  List<Task> allTasks = [];

  int actualTimeRemainingOfTheSession = 0;
  int timeRemainingOfTheTask = 0;
  int totalTimersOfAllTasks = 0;

  bool startTimer = false;
  late TaskController taskController;

  @override
  void initState() {
    startShowCase();

    calActualTime();
    startSession();
    taskController = TaskController(context: context);

    super.initState();
  }

  void startShowCase() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool seen = preferences.getBool('seen') ?? false;
    if (seen) {
      return;
    } else {
      await preferences.setBool('seen', true);
      WidgetsBinding.instance.addPostFrameCallback(
          (_) => ShowCaseWidget.of(context).startShowCase([
                _one,
                _two,
                _three,
                _four,
                _five,
                _six,
              ]));
    }
  }

  void startSession() {
    _timeAttheBegining = DateTime.now().add(const Duration(minutes: 5));
    var totalTimers = taskCubit.getTotalTimers();
    _timeAttheEnd = DateTime.now().add(Duration(minutes: totalTimers));
  }

  void calActualTime() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          var diff = _timeAttheEnd.difference(DateTime.now());
          actualTimeRemainingOfTheSession = diff.inMinutes;
          actualTimeRemainingOfTheSession;
        });
      },
    );
  }

  bool isSesionStarted() {
    return (_timeAttheBegining.isBefore(DateTime.now()));
  }

  Future pickFirstTime(
      {required BuildContext context,
      required DateTime timeAtTheBegining}) async {
    startTimer = false;
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: timeAtTheBegining,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (date == null || date.day < DateTime.now().day) {
      _showWrongDateOrTime(context);
      return;
    }
    final firstTime = TimeOfDay.now();
    if (context.mounted) {
      TimeOfDay? time =
          await showTimePicker(context: context, initialTime: firstTime);
      if (time == null) {
        return;
      }
      _timeAttheBegining =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
    }

    if (_timeAttheBegining.isBefore(DateTime.now())) {
      _showWrongDateOrTime(context);
      setState(() {
        _timeAttheBegining = DateTime.now();
      });
      return;
    }

    setState(() {
      _timeAttheBegining;
    });
  }

  void _showWrongDateOrTime(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: SizedBox(
            height: 100,
            child: Column(
              children: [
                const Text('Your date and Time should be in the future!'),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    DateTime timeAtEachTask = DateTime.now();
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            allTasks = state.tasks;
            DateTime timeDisplayedAtTheEndOfAllTasks =
                DateTime.now().add(Duration(minutes: totalTimersOfAllTasks));

            return Column(
              children: [
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 232, 232),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 5,
                      color: const Color.fromARGB(255, 151, 138, 189),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TopTitle(
                        actualTimeRemaining: actualTimeRemainingOfTheSession,
                        isSesionStarted: isSesionStarted(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      pickStartTimeAndEndTime(),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * .01,
                ),
                Container(
                  height: size.height * .1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 239, 232, 232),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      width: 5,
                      color: const Color.fromARGB(255, 151, 138, 189),
                    ),
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (timeRemaining > actualTimeRemainingOfTheSession) {
                          setState(() {
                            timeRemaining = actualTimeRemainingOfTheSession;
                          });
                        }
                        addNewTaskCard();
                        timeBalance();
                      },
                      child: CustomShowCase(
                          description: 'add new task with timer in minutes',
                          globalkey: _three,
                          child: const Text('Add task with timer'))),
                ),
                if (isSesionStarted())
                  Text(
                      'If you start now  --> ${DateTime.now().hour.toString().padLeft(2, '0')} :'
                      '${DateTime.now().minute.toString().padLeft(2, '0')}'),
                Expanded(
                    child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) =>
                      taskController.updateMyTaskOrder(oldIndex, newIndex),
                  itemCount: allTasks.length,
                  itemBuilder: (context, index) {
                    int accumalatedTime = allTasks[index].period +
                        (allTasks[index].period / 5).round();

                    timeAtEachTask =
                        timeAtEachTask.add(Duration(minutes: accumalatedTime));

                    return Dismissible(
                      onDismissed: (direction) {
                        taskController.deleteTask(index);
                        timeBalance();
                      },
                      key: Key(allTasks[index].id),
                      child: GestureDetector(
                          onDoubleTap: () {
                            taskController.doubleThisTask(
                                allTasks[index], index);
                          },
                          onTap: () {
                            // EditTask(task: state.tasks[index]);
                            editTask(context, allTasks[index]);
                            timeBalance();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                TaskCardWidget(
                                    four: _four,
                                    task: allTasks[index],
                                    currentIndex: index,
                                    maxIndex: allTasks.length,
                                    size: size,
                                    taskController: taskController),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    if (_timeAttheBegining
                                        .isBefore(DateTime.now()))
                                      Text(
                                          '${timeAtEachTask.hour.toString().padLeft(2, '0')}:'
                                          '${timeAtEachTask.minute.toString().padLeft(2, '0')}'),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                )),
                if (isSesionStarted())
                  Text(
                      '${'You will finish at--> ${timeDisplayedAtTheEndOfAllTasks.hour}'.toString().padLeft(2, '0')}:${timeDisplayedAtTheEndOfAllTasks.minute.toString().padLeft(2, '0')}'),
                if (allTasks.isNotEmpty)
                  TextButton(
                      onPressed: () {
                        setState(() {
                          BlocProvider.of<TaskCubit>(context).deleteAll();
                          timeBalance();
                        });
                      },
                      child: const Text('Delete all tasks')),
                actualTimeRemainingOfTheSession > 0
                    ? SizedBox(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            timeBalance() >= 0
                                ? const Text(
                                    'Time to arrange ---> ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue),
                                  )
                                : const Text(
                                    'You better doing your task ---> ',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.blue),
                                  ),
                            Text(
                              timeBalance().toString(),
                              style: TextStyle(
                                  fontSize: 30,
                                  color: timeBalance() > 0
                                      ? Colors.green
                                      : Colors.red),
                            ),
                          ],
                        ))
                    : TextButton(
                        onPressed: startSession,
                        child: const Text('Start new session ')),
              ],
            );
          },
        ),
      ),
    );
  }

  String getFirstText() {
    return '${_timeAttheBegining.hour}:${_timeAttheBegining.minute}';
  }

  String getEndText() {
    return '${_timeAttheEnd.hour}:${_timeAttheEnd.minute}';
  }

  String getDiffText() {
    var diff = _timeAttheEnd.difference(_timeAttheBegining);

    if (startTimer == false) {
      timeRemaining = diff.inMinutes;
      actualTimeRemainingOfTheSession = diff.inMinutes;
      startTimer = true;
    }

    return '${diff.inMinutes}';
  }

  Future pickEndTime() async {
    startTimer = false;
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: _timeAttheEnd,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (date == null || date.day < DateTime.now().day) {
      _showWrongDateOrTime(context);
      return;
    }

    if (context.mounted) {
      TimeOfDay? time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay(
              hour: _timeAttheEnd.hour, minute: _timeAttheEnd.minute));
      if (time == null) {
        return;
      }
      _timeAttheEnd =
          DateTime(date.year, date.month, date.day, time.hour, time.minute);
      if (_timeAttheEnd.isBefore(DateTime.now())) {
        _showWrongDateOrTime(context);
        setState(() {
          _timeAttheEnd = DateTime.now().add(const Duration(minutes: 25));
        });
        return;
      }

      setState(() {
        _timeAttheEnd =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
      });
    }
  }

  Row pickStartTimeAndEndTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text('Start at',
            style: TextStyle(
                fontSize: 15, color: Color.fromARGB(255, 12, 145, 233))),
        CustomShowCase(
          description: 'pick start time',
          globalkey: _one,
          child: GestureDetector(
              onTap: () {
                pickFirstTime(
                    context: context, timeAtTheBegining: _timeAttheBegining);
              },
              child: Text(
                style: const TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 63, 97, 47)),
                getFirstText(),
              )),
        ),
        const Text('To', style: TextStyle(fontSize: 15, color: Colors.blue)),
        CustomShowCase(
          description: 'pick end time',
          globalkey: _two,
          child: GestureDetector(
              onTap: () {
                pickEndTime();
              },
              child: Text(getEndText(),
                  style: const TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 63, 97, 47)))),
        ),
        const Text('Total in min',
            style: TextStyle(fontSize: 15, color: Colors.blue)),
        Text(getDiffText(),
            style: const TextStyle(
                fontSize: 20, color: Color.fromARGB(255, 63, 97, 47))),
      ],
    );
  }

  void runTimer(Task task) async {
    FlutterAlarmClock.createTimer(task.period * 60, title: task.title);

    (task.period / 5).round();
  }

  void runRestTimer(Task task) {
    var restTimer = (task.period / 5).round();
    FlutterAlarmClock.createTimer(restTimer * 60, title: 'Rest time');
  }

  int timeBalance() {
    var totalTimers = 0;
    for (var task in allTasks) {
      totalTimers += (task.period * 6 / 5).round();
    }
    totalTimersOfAllTasks = totalTimers;
    if (_timeAttheBegining.isBefore(DateTime.now())) {
      timeRemaining = actualTimeRemainingOfTheSession - totalTimers;
    } else {
      timeRemaining =
          _timeAttheEnd.difference(_timeAttheBegining).inMinutes - totalTimers;
    }
    return timeRemaining;
  }

  void addNewTaskCard() {
    showDialog(
      context: context,
      builder: (context) {
        return AddNewTask();
      },
    );
  }
}
