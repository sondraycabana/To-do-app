
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../model/task_model.dart';



class TaskFirestoreServiceProvider extends ChangeNotifier {
  final String uid;
  final Logger _logger = Logger();

  TaskFirestoreServiceProvider({required this.uid});

  static const String _tasksCollectionName = 'tasks';
  final CollectionReference _taskCollection =
  FirebaseFirestore.instance.collection(_tasksCollectionName);

  /// Adds a new task to the Firestore collection.
  Future<void> addTask(String taskTitle, List<String> items) async {
    try {
      await _taskCollection.add({
        'userId': uid,
        'taskTitle': taskTitle,
        'items': items,
      });
    } catch (e) {
      _logger.e("Error adding task: $e");
      rethrow;
    }
  }

  /// Edits an existing task in the Firestore collection.
  Future<void> editTask(String docId, Map<String, dynamic> updatedData) async {
    try {
      await _taskCollection.doc(docId).update(updatedData);
    } catch (e) {
      _logger.e("Error editing task: $e");
      rethrow;
    }
  }

  /// Deletes a task from the Firestore collection.
  Future<void> deleteTask(String docId) async {
    try {
      await _taskCollection.doc(docId).delete();
    } catch (e) {
      _logger.e("Error deleting task: $e");
      rethrow;
    }
  }

  /// Streams the tasks for the current user from the Firestore collection.
  Stream<List<Tasks>> streamTasks() {
    return _taskCollection
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map((doc) => Tasks.fromFirestore(doc)).toList());
  }
}
