import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_orginizer/logic/cubit/task_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:showcaseview/showcaseview.dart';

import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
            cardColor: const Color.fromARGB(210, 57, 55, 51),
            scaffoldBackgroundColor: const Color.fromARGB(95, 32, 31, 30)),
        home: ShowCaseWidget(
          builder: Builder(
            builder: (context) => const MyHomePage(),
          ),
        ),
      ),
    );
  }
}
