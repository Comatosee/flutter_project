import 'package:flutter/material.dart';
import '../presentation/task_list_screen.dart';
import '../presentation/create_task_screen.dart';
import '../presentation/task_bloc_provider.dart';
import '../domain/task_bloc.dart';

void main() {
  runApp(TaskBlocProvider(
    taskBloc: TaskBloc(),
    appWidget: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TaskListScreen(),
        '/newTask': (context) => const CreateTaskScreen(),
      },
    );
  }
}