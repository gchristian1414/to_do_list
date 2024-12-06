import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart'; 
import 'package:to_do_list_android/DatabaseService.dart';

void main() {
  late DatabaseService databaseService;

//runs before each test to setup 
  setUpAll(() {
    // sql for testing 
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    databaseService = DatabaseService.instance;
  });
//runs before each test to delete what is inside the tasks table to be able to reset the table for each test to run its tests.
  tearDown(() async {
    final db = await databaseService.database;
    await db.execute('DELETE FROM tasks'); 
  });

  test('Add a task to the database', () async {
    final taskId = await databaseService.addTask('Test Task', 'Test Content', '10:00 AM');
    expect(taskId, isNotNull);//expects that the taskID that is added is not null.
    expect(taskId, greaterThan(0));//expects that the ID is >0 meaning a task was added.
  });

  test('Fetch tasks from the database', () async {
    await databaseService.addTask('Task 1', 'Content 1', '9:00 AM');
    await databaseService.addTask('Task 2', 'Content 2', '10:00 AM');
    final tasks = await databaseService.fetchTasks();
    expect(tasks.length, 2);//expects that there are 2 tasks
    expect(tasks[0]['title'], 'Task 1'); 
    expect(tasks[1]['title'], 'Task 2');//expects that the two tasks in 'tasks' match up to the ones that were added
  });

  test('Update a task', () async {
    final taskId = await databaseService.addTask('Task 1', 'Content', '11:00 AM');
    await databaseService.updateTaskDetails(taskId, 'Updated Task 1', 'New Content', '12:00 PM');//updates the tasks that was added
    final tasks = await databaseService.fetchTasks();
    expect(tasks[0]['title'], 'Updated Task 1');
    expect(tasks[0]['time'], '12:00 PM');//expects that the title and time reflect the new ones that were updated
  });

  test('Delete a task', () async {
    final taskId = await databaseService.addTask('Task to Delete', 'Content to Delete', '3:00 PM');
    await databaseService.deleteTask(taskId);
    final tasks = await databaseService.fetchTasks();
    expect(tasks.isEmpty, true);//adds a task and then exceutes the deleteTask to delete it and expects that the tasks list is empty.
  });

  test('Fetch tasks from an empty database', () async {
  final tasks = await databaseService.fetchTasks();
  expect(tasks.isEmpty, true); //expects an empty list because there is nothing in the database stored.
});
}