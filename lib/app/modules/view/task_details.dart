import 'package:assessment/app/utils/Extensions/size_box_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../model/task_model.dart';

class TaskDetail extends StatefulWidget {
  final Tasks task;

  const TaskDetail({super.key, required this.task});

  @override
  TaskDetailState createState() => TaskDetailState();
}

class TaskDetailState extends State<TaskDetail> {
  final TextEditingController _itemController = TextEditingController();
  late List<String> _items;
  late List<bool> _checkedItems;

  @override
  void initState() {
    super.initState();
    _items = List<String>.from(widget.task.items);
    _checkedItems = List<bool>.filled(_items.length, false, growable: true);
  }

  void _addItem() {
    if (_itemController.text.isNotEmpty) {
      setState(() {
        _items.add(_itemController.text);
        _checkedItems.add(false);
        updateItemsInFireStore();
        _itemController.clear();
      });
    }
  }

  Future<void> updateItemsInFireStore() async {
    try {
      await FirebaseFirestore.instance
          .collection('tasks')
          .doc(widget.task.id)
          .update({'items': _items});
    } catch (e) {
      if (kDebugMode) {
        print('Error updating items: $e');
      }
    }
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
      _checkedItems.removeAt(index);
      updateItemsInFireStore();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.task.taskTitle,
                    style: const TextStyle(
                        fontSize: 32,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
          12.h,
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: SizedBox(
                    width: 22,
                    height: 22,
                    child: Checkbox(
                      value: _checkedItems[index],
                      onChanged: (bool? value) {
                        setState(() {
                          _checkedItems[index] = value ?? false;
                        });
                      },
                      checkColor: const Color(0xFFFFFFFF),
                    ),
                  ),
                  title: Text(
                    _items[index],
                    style: TextStyle(
                      decoration: _checkedItems[index]
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const ImageIcon(
                      AssetImage('assets/images/png/trash.png'),
                      color: AppColors.neutralBaseGreyColor,
                    ),
                    onPressed: () => _deleteItem(index),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _itemController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(color: AppColors.primaryColor),
                labelText: 'Add main task',
                prefixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addItem,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
