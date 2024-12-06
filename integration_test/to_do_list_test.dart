import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_list_android/main.dart' as app;

void main() {
  group('To-Do App Integration Test', () {
    testWidgets('Flow of the app: Signup, Login, Add, Edit, and Deleting a task', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.text('Login'), findsOneWidget);
      await tester.enterText(find.byType(TextField).at(0), 'user@gmail.com'); 
      await tester.enterText(find.byType(TextField).at(1), 'user123'); 
      await tester.tap(find.text('Signup'));//the user might already be created if not it still works it displays the error message and continues
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(seconds: 2));//wait 2 second to account for the account creation 
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      expect(find.text('To-Do List'), findsOneWidget);//expect to be in the home screen
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();
      expect(find.text('Add Task'), findsOneWidget);//expect to be in the add task screen

      await tester.enterText(find.byType(TextField).at(0), 'Test Task');
      await tester.enterText(find.byType(TextField).at(1), 'Test Content');
      await tester.enterText(find.byType(TextField).at(2), '1:00 PM');//input task
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      expect(find.text('Test Task'), findsOneWidget);
      expect(find.text('Test Content'), findsOneWidget);//check that task in in the list

      await tester.tap(find.text('Edit'));
      await tester.pumpAndSettle();
      expect(find.text('Edit'), findsOneWidget);//expect to be in the edit task screen

      await tester.enterText(find.byType(TextField).at(0), 'Updated Test Task');
      await tester.enterText(find.byType(TextField).at(1), 'Updated Content');
      await tester.enterText(find.byType(TextField).at(2), '2:00 PM');
      await tester.tap(find.text('Update'));
      await tester.pumpAndSettle();
      expect(find.text('Updated Test Task'), findsOneWidget);
      expect(find.text('Updated Content'), findsOneWidget);//check that task updated

      await tester.drag(find.text('Updated Test Task'), const Offset(-500.0, 0.0));//imitate the swipe motion from the right on the dismissable to delete the task
      await tester.pumpAndSettle();

      expect(find.text('Updated Test Task'), findsNothing);//check that task was deleted
    });
  });
}