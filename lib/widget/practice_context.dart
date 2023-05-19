// import 'package:flutter/material.dart';

// class PracticeContext extends StatelessWidget {
//   const PracticeContext({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       child: Row(
//         children: [
//           Flexible(flex: 1, child: Practice1()),
//           // Flexible(
//           //     flex: 1,
//           //     child: SizedBox(
//           //       child: Practice3( context),
//           //     )),
//         ],
//       ),
//     );
//   }
// }

// class Practice1 extends StatelessWidget {
//   const Practice1({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('practice1${size.width}'),
//       ),
//       body: Container(),
//     );
//   }
// }

// class Practice2 extends StatelessWidget {
//   const Practice2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('practice2'),
//       ),
//       body: Container(),
//     );
//   }
// }

// Widget Practice3(BuildContext context) {
//   Size size = MediaQuery.of(context).size;
//   return Container(
//     child: Text('practice1${size.width}'),
//   );
// }
