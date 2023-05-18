import 'package:my_orginizer/models/task.dart';

class Session {
  DateTime timeAtTheBegining = DateTime.now().add(const Duration(minutes: 5));
  DateTime timeAttheEnd = DateTime.now().add(const Duration(minutes: 120));
  DateTime? reminder;
  int timeRemaining = 0;
  List<Task> tasks = [];
  int get totalTimeInMinute =>
      timeAttheEnd.difference(timeAtTheBegining).inMinutes;
  int get actualTimeBalanceInMinute =>
      timeAttheEnd.difference(DateTime.now()).inMinutes;
}
