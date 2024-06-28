import 'package:cloud_firestore/cloud_firestore.dart';

class Tasks {
  final String id;
  final String userId;
  final String taskTitle;
   final List<String> items;


  Tasks({
    required this.id,
    required this.userId,
    required this.taskTitle,
    required this.items,

  });

  factory Tasks.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Tasks(
      id: doc.id,
      userId: data['userId'] ?? '',
      taskTitle: data['taskTitle'] ?? '',
      items: List<String>.from(data['items'] ?? []),

    );
  }
}




