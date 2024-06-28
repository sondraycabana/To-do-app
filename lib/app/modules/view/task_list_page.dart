import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';
import '../model/task_model.dart';
import 'task_detail_page.dart';

class TaskListPage extends StatefulWidget {
  final dynamic user;

  const TaskListPage({Key? key, required this.user}) : super(key: key);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int _totalTasks = 0;
  late TaskFirestoreServiceProvider _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService =
        Provider.of<TaskFirestoreServiceProvider>(context, listen: false);
    _fetchTotalTasks();
  }

  void _fetchTotalTasks() async {
    try {
      List<Tasks> tasks = await _firestoreService.streamTasks().first;
      setState(() {
        _totalTasks = tasks.length;
      });
    } catch (e) {
      print('Error fetching total tasks: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.purple,
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          50.h,
                          const Text(
                            'Amazing Journey',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          8.h,
                          const Text(
                            'You have successfully ',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: "Inter",
                                color: Colors.white),
                          ),
                          Text(
                            'finished $_totalTasks notes.',
                            style: const TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    16.w,
                  ],
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 40,
                  child: Image.asset(
                    'assets/images/png/Illustrationnote-img.png',
                    height: 240,
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TaskList(user: widget.user),
          ),
        ],
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  final dynamic user;

  const TaskList({Key? key, required this.user}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late TaskFirestoreServiceProvider _firestoreService;

  @override
  void initState() {
    super.initState();
    _firestoreService =
        Provider.of<TaskFirestoreServiceProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Tasks>>(
      stream: _firestoreService.streamTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading tasks: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks found'));
        } else {
          List<Tasks> tasks = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskDetailPage(task: task),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  'assets/images/png/trolley.png',
                                  height: 30,
                                  width: 30,
                                ),
                                8.w,
                                Expanded(
                                  child: Text(
                                    task.taskTitle,
                                    style: const TextStyle(
                                      fontFamily: "Inter",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            8.h,
                            Container(
                              height: 66,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: task.items.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: false,
                                        onChanged: (value) {
                                          setState(() {});
                                        },
                                      ),
                                      Text(task.items[index])
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          color: Colors.purple,
                          height: 28,
                          width: double.infinity,
                          child: const Text(
                            "Task",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Inter",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
