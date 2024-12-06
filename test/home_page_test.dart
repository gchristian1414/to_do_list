import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list_android/AddTaskScreen.dart';
import 'package:to_do_list_android/editTaskScreen.dart';
import 'package:to_do_list_android/home_page.dart';
import 'package:to_do_list_android/DatabaseService.dart';
import 'package:to_do_list_android/task_card.dart';

void main() {
  late DatabaseService dbService;

  setUpAll(() {
    // Initialize ffi for sqflite
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    dbService = DatabaseService.instance;
  });

  tearDown(() async {
    final db = await dbService.database;
    await db.execute('DELETE FROM tasks'); // Clear database before each test
  });

  testWidgets('HomePage Appbar displays the correct title', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomePage()));
    expect(find.text('To-Do List'), findsOneWidget);//expects the appbar to say 'To-Do List'
  });


  testWidgets('AddTaskScreen has input fields and a submit button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AddTaskScreen()));//starts AddTaskScreen
    expect(find.byType(TextField), findsNWidgets(3)); //once going to the AddTaskScreen it expects to find 3 textfields
    expect(find.text('Submit'), findsOneWidget);//expects to see the submit button
  });

testWidgets('EditTaskScreen displays task details', (WidgetTester tester) async {
    //create a task
    final task = Task(
      id: '1',
      title: 'Task Title',
      subtitle: 'Task Content',
      time: '10:00 AM',
      isDon: false,
    );

   //go to edittask
    await tester.pumpWidget(MaterialApp(
      home: EditTaskScreen(task: task),
    ));

   
    expect(find.text('Task Title'), findsOneWidget);
    expect(find.text('Task Content'), findsOneWidget);
    expect(find.text('10:00 AM'), findsOneWidget);//expects that the editTask fields are populated with the parameters the task selected.
  });

  testWidgets('Add button is visible on HomePage', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: HomePage()));
  expect(find.byIcon(Icons.add), findsOneWidget);//expects to see the add button on the bottom right
});

testWidgets('Tapping Add button navigates to AddTaskScreen', (WidgetTester tester) async {
  await tester.pumpWidget(MaterialApp(home: HomePage()));
  await tester.tap(find.byIcon(Icons.add));
  await tester.pumpAndSettle(); 
  expect(find.text('Add Task'), findsOneWidget); //once the add has been pressed it sends to the add task where it expects the AppBar title to be 'Add Task'
  expect(find.byType(TextField), findsNWidgets(3));//expects there to be the 3 text fields in the AddTaskScreen
});

}