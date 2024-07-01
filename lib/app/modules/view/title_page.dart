import 'package:accessment/app/modules/view/task_list_page.dart';
import 'package:accessment/app/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accessment/app/modules/provider/task_provider.dart'; // Import TaskFirestoreServiceProvider
import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import '../../config/routes/routes.dart';
import '../../constants/app_colors.dart';

class TitlePage extends StatefulWidget {
  final dynamic user;

  const TitlePage({Key? key, required this.user}) : super(key: key);

  @override
  _TitlePageState createState() => _TitlePageState();
}

class _TitlePageState extends State<TitlePage> {
  late TaskFirestoreServiceProvider _firestoreService;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _itemController = TextEditingController();
  final List<String> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firestoreService =
        Provider.of<TaskFirestoreServiceProvider>(context, listen: false);
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _addTask() async {
    if (_titleController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _firestoreService.addTask(_titleController.text, _items);
        // Navigator.pushNamed(context, Routes.taskListPage,
        //     arguments: widget.user);

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskListPage( user:  widget.user,)),

        );
      } catch (e) {
        _showErrorSnackBar('Error adding task: $e');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showErrorSnackBar('Title cannot be empty');
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Back',
          style: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
            fontSize: 16,
            fontFamily: "Inter",
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.h,
                  const Text(
                    AppStrings.titlePageText,
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F8B96),
                    ),
                  ),
                  16.h,
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: "Add main task",
                      prefixIcon: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: _addTask,
                      ),
                    ),
                    style: const TextStyle(
                      color: AppColors.neutralBlackColor,
                      fontFamily: "Inter",
                    ),
                  ),
                  20.h,
                  const Text(
                    'Items',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Inter",
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8F8B96),
                    ),
                  ),
                  16.h,
                  Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(_items[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                _items.removeAt(index);
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
