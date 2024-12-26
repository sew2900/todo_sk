import 'package:flutter/material.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.lightBlue[50], // Background color for the scaffold
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87), // Default text color
        ),
      ),
      home: ToDoListPage(),
    );
  }
}

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final List<Map<String, dynamic>> _tasks = []; // List to store tasks
  final TextEditingController _controller = TextEditingController(); // Controller for the TextField

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add({
          'title': _controller.text, // Add new task with title from the TextField
          'completed': false, // Initially the task is not completed
        });
        _controller.clear(); // Clear the TextField after adding the task
      });
    }
  }

  void _toggleTask(int index) {
    setState(() {
      _tasks[index]['completed'] = !_tasks[index]['completed']; // Toggle the completion status of the task
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index); // Remove the task from the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        backgroundColor: Colors.blue[700], // AppBar color
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Add task', // Placeholder for the TextField
                      filled: true,
                      fillColor: Colors.white, // Background color of the TextField
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTask,
                  child: Text('Add'), // Button to add a new task
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent, // Button color
                    foregroundColor: Colors.white, // Text color
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length, // Number of tasks in the list
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Card( // Use Card widget for better visual separation
                  color: Colors.white,
                  elevation: 3,
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: ListTile(
                    title: Text(
                      task['title'],
                      style: TextStyle(
                        decoration: task['completed']
                            ? TextDecoration.lineThrough // If the task is completed, the text is strikethrough
                            : TextDecoration.none,
                        color: task['completed'] ? Colors.grey : Colors.black, // Change text color when completed
                      ),
                    ),
                    leading: IconButton(
                      icon: Icon(
                        task['completed'] ? Icons.check_box : Icons.check_box_outline_blank, // Icon changes based on task completion
                        color: task['completed'] ? Colors.green : Colors.black, // Change icon color when completed
                      ),
                      onPressed: () => _toggleTask(index), // Toggle the task's completion status
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteTask(index), // Delete the task from the list
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
