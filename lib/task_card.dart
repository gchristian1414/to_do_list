import 'package:flutter/material.dart';
import 'package:to_do_list_android/editTaskScreen.dart';
import 'package:to_do_list_android/home_page.dart';

class Task_Widget extends StatefulWidget {
  final Task note;
  final VoidCallback onRefresh;
  final void Function(String id) onToggle;

  Task_Widget(this.note, {required this.onToggle,required this.onRefresh, super.key});

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.note.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Checkbox(
                    activeColor: Colors.green,
                    value: widget.note.isDon,
                    onChanged: (value) {
                      widget.onToggle(widget.note.id); 
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.note.subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey,
                  ),
                ),
              ),
              Spacer(),
              edit_task(),
            ],
          ),
        ),
      ),
    );
  }

  Widget edit_task() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 115,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.white, size: 16),
                  SizedBox(width: 10),
                  Text(
                    widget.note.time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20),
          GestureDetector(
            onTap: () {Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => (EditTaskScreen(task: widget.note,)
              ),
            )
          ).then((_){
            widget.onRefresh();
          });},
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.black, size: 16),
                    SizedBox(width: 10),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}