import 'package:flutter/material.dart';
import '../domain/task_bloc.dart';

class TaskBlocProvider extends InheritedWidget {
  final TaskBloc taskBloc;
  final Widget appWidget;

  const TaskBlocProvider({
    Key? key,
    required this.taskBloc,
    required this.appWidget,
  }) : super(key: key, child: appWidget);

  static TaskBlocProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TaskBlocProvider>();
  }

  @override
  bool updateShouldNotify(TaskBlocProvider oldWidget) {
    return taskBloc != oldWidget.taskBloc;
  }
}
