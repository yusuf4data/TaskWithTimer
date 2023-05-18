
import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  const TopTitle({
    Key? key,
    required this.actualTimeRemaining,
    required this.isSesionStarted,
  }) : super(key: key);

  final int actualTimeRemaining;
  final bool isSesionStarted;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          'Schedual your session',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
        if (isSesionStarted)
          Container(
            color: Colors.yellow,
            child: Text(
              'Actual timer--> $actualTimeRemaining min',
              style: const TextStyle(fontSize: 13, color: Colors.blue),
            ),
          ),
      ],
    );
  }
}