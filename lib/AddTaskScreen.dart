import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list_android/DatabaseService.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final taskController = TextEditingController();
  final contentController = TextEditingController();
  final timeController = TextEditingController();

   String getCurrentUserID() {
    final user = FirebaseAuth.instance.currentUser;
    return user?.uid ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        backgroundColor: Colors.white,
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
                border: OutlineInputBorder(),
                hintText: "Content",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: timeController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Time"),
            ),
            //SizedBox(height: 30,),
            SizedBox(
              height: 16,
            ),

            SizedBox(
              height: 30,
            ),
            Center(
              child: ElevatedButton(
                  onPressed: () async {
                    String taskTitle = taskController.text.trim();
                    String taskContent = contentController.text.trim();
                    String taskTime = timeController.text.trim();
                    

                    if (taskTime.isEmpty || taskTime.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Task and Time are Required")),
                      );
                      return;
                    }
                    await _databaseService.addTask(taskTitle, taskContent, taskTime);
                    Navigator.pop(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
