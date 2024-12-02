import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:to_do_list_android/AddTaskScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_list_android/DatabaseService.dart';
import 'package:to_do_list_android/task_card.dart'; 
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Task> notes = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }
  
  Future<void> _loadTasks() async {
    
    final taskList = await _databaseService.fetchTasks();
    setState(() {
      notes = taskList.map((task) {
        return Task(
          id: task['id'].toString(),
          title: task['title'],
          subtitle: task['subtitle'] ?? '',
          time: task['time'],
          isDon: task['isDon'] == 1,
        );
      }).toList();
    });
  }

  void _addTask(String title, String subtitle, String time) async {
    
    await _databaseService.addTask(title, subtitle, time);
    _loadTasks();
  }

  void _toggleTask(String id) async {
    final note = notes.firstWhere((note) => note.id == id);
    await _databaseService.updateTask(int.parse(id), note.isDon ? 0 : 1);
    _loadTasks();
  }

  void _deleteTask(String id) async {
    await _databaseService.deleteTask(int.parse(id));
    _loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'To-Do List',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final note = notes[index];
          return Dismissible(
              key: Key(note.id),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) {
                _deleteTask(note.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  ("${note.title} task deleted"),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),backgroundColor: Colors.red,));
              },
              background: Container(
                padding: EdgeInsets.all(20),
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              child: Task_Widget(
                note,
                onToggle: _toggleTask,
                onRefresh: _loadTasks,
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskScreen()),
          );
          _loadTasks();
        },
        child: Icon(Icons.add,color: Colors.white,),
      ),
      
    );
  }

  
}

class Task {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  bool isDon; 

  Task({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isDon,
  });
}
