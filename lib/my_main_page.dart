import 'package:flutter/material.dart';
import 'package:my_orginizer/home_page.dart';
import 'package:my_orginizer/my_tasks_page.dart';

class MyMainPage extends StatefulWidget {
  const MyMainPage({Key? key}) : super(key: key);

  @override
  _MyMainPageState createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {
  List<Widget> pages = [const MyHomePage(), const MyTasksPage()]; //
  int CurrentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[CurrentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              CurrentPageIndex = value;
            });
          },
          currentIndex: CurrentPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_sharp), label: 'Tasks with Timers'),
            BottomNavigationBarItem(
                icon: Icon(Icons.timer_sharp), label: 'Tasks'),
          ]),
    );
  }
}
