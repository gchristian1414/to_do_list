import 'package:flutter/material.dart';
import 'package:to_do_list_android/DatabaseService.dart';

import 'home_page.dart';

class EditTaskScreen extends StatefulWidget {
  final Task task;
  EditTaskScreen({required this.task, Key? key}): super (key: key);
  @override
  State<StatefulWidget> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController taskController;
  //final taskController = TextEditingController();
  late TextEditingController contentController;
  //final contentController = TextEditingController();
  late TextEditingController timeController;
  //final timeController = TextEditingController();
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  void initState(){
    
    taskController = TextEditingController(text: widget.task.title);
    contentController = TextEditingController(text: widget.task.subtitle);
    timeController = TextEditingController(text: widget.task.time);

  }
  @override
  void _updateTask() async{
    String updatedTitle = taskController.text.trim();
    String updatedContent = contentController.text.trim();
    String updatedTime = timeController.text.trim();

    if(updatedTitle.isEmpty || updatedTime.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Task title and Time cannot be empty",
       style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
       backgroundColor: Colors.red,)
      );
      return;
    }
    await _databaseService.updateTaskDetails(int.parse(widget.task.id), 
    updatedTitle, 
    updatedContent, 
    updatedTime);
    Navigator.pop(context);
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Edit",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Task"),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: contentController,
              maxLines: 5,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Content"),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Time",
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: _updateTask,
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    "Update",
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
