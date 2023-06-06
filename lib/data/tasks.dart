import 'dart:convert';

class Task {
  String title;
  String description;
  bool completed;

  Task(this.title, this.description, {this.completed = false});


  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'completed': completed,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      map['title'],
      map['description'],
      completed: map['completed'],
    );
  }

  static List<Task> fromJsonList(String json) {
    final decoded = jsonDecode(json) as List<dynamic>;
    return decoded.map((item) => Task.fromMap(item)).toList();
  }

  static String toJsonList(List<Task> tasks) {
    final jsonList = tasks.map((task) => task.toMap()).toList();
    return jsonEncode(jsonList);
  }
}
