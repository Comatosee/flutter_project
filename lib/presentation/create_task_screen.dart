import 'package:flutter/material.dart';
import '../data/tasks.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({Key? key}) : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Task? taskToEdit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      taskToEdit = ModalRoute.of(context)?.settings.arguments as Task?;
      if (taskToEdit != null) {
        _titleController.text = taskToEdit!.title;
        _descriptionController.text = taskToEdit!.description;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 236, 205),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(EvaIcons.arrowCircleLeft),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color.fromARGB(255, 232, 164, 44),
        title: const Text('Новая задача'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              onChanged: (value) {
                taskToEdit?.title = value;
              },
              decoration: const InputDecoration(
                labelText: 'Заголовок',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: _descriptionController,
              onChanged: (value) {
                taskToEdit?.description = value;
              },
              decoration: const InputDecoration(
                labelText: 'Описание',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                String newTitle = _titleController.text;
                String newDescription = _descriptionController.text;
                Task newTask = Task(newTitle, newDescription);
                if (taskToEdit != null) {
                  newTask.completed = taskToEdit!.completed;
                  Navigator.pop(context, newTask);
                } else {
                  Navigator.pop(context, newTask);
                }
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 232, 164, 44)
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Сохранить'),
                  Icon(EvaIcons.save)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}

