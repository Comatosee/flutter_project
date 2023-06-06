import 'package:flutter/material.dart';
import '../data/tasks.dart';
import '../domain/task_bloc.dart';
import '../presentation/task_bloc_provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({Key? key}) : super(key: key);

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late TaskBloc taskBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = TaskBlocProvider.of(context);
    if (provider != null) {
      taskBloc = provider.taskBloc;
      taskBloc.fetchTasks();
    }
  }

  @override
  void dispose() {
    taskBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 236, 205),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 232, 164, 44),
        title: const Text('Список задач'),
      ),
      body: StreamBuilder<List<Task>>(
        stream: taskBloc.tasksStream,
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];
          return GridView.builder(
            padding: EdgeInsets.zero,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 1.0,
            ),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              Task task = tasks[index];
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListTile(
                  title: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    task.description,
                    style: const TextStyle(fontSize: 12.0, color: Colors.white70),
                  ),
                  trailing: Checkbox(
                    activeColor: Colors.green,
                    value: task.completed,
                    onChanged: (value) {
                      taskBloc.updateTaskCompletion(task, value!);
                    },
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/newTask', arguments: task)
                        .then((editedTask) {
                      if (editedTask != null) {
                        taskBloc.updateTask(editedTask as Task);
                      }
                    });
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/newTask').then((newTask) {
              if (newTask != null) {
                taskBloc.addTask(newTask as Task);
              }
            });
          },
          backgroundColor: const Color.fromARGB(255, 232, 164, 44),
          child: const Icon(
            EvaIcons.plus,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
