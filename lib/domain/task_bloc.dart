import 'package:rxdart/rxdart.dart';
import '../data/tasks.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskBloc {
  final BehaviorSubject<List<Task>> _tasksController =
  BehaviorSubject<List<Task>>();
  Stream<List<Task>> get tasksStream => _tasksController.stream;

  List<Task> _tasks = [];

  void fetchTasks() {
    _fetchTasksFromSharedPreferences();
  }

  void _fetchTasksFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    if (tasksJson != null) {
      _tasks = Task.fromJsonList(tasksJson);
    }
    _tasksController.add(_tasks);
  }

  void addTask(Task task) {
    _tasks.add(task);
    _updateTasksInSharedPreferences();
    _tasksController.add(_tasks);
  }

  void updateTask(Task updatedTask) {
    final index =
    _tasks.indexWhere((task) => task.title == updatedTask.title);
    if (index != -1) {
      _tasks[index] = updatedTask;
      _updateTasksInSharedPreferences();
      _tasksController.add(_tasks);
    }
  }

  void updateTaskCompletion(Task task, bool completed) {
    task.completed = completed;
    _updateTasksInSharedPreferences();
    _tasksController.add(_tasks);
  }

  Future<void> saveTasks() async {
    await _updateTasksInSharedPreferences();
  }

  Future<void> _updateTasksInSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final updatedTasksJson = Task.toJsonList(_tasks);
    await prefs.setString('tasks', updatedTasksJson);
  }

  void dispose() {
    _tasksController.close();
  }
}
