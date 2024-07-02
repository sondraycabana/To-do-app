import 'package:accessment/app/constants/app_colors.dart';
import 'package:accessment/app/constants/asset_paths.dart';
import 'package:accessment/app/modules/view/settings_screen.dart';
import 'package:accessment/app/modules/view/title_page.dart';
import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:accessment/app/utils/app_strings/app_strings.dart';
import 'package:flutter/material.dart';
import '../model/task_model.dart';
import '../services/task_firestore_service.dart';
import 'task_detail_page.dart';

class TaskListPage extends StatefulWidget {
  final dynamic user;

  const TaskListPage({Key? key, required this.user}) : super(key: key);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  int _totalTasks = 0;
  late TaskFirestoreService _firestoreService;

  @override
  void initState() {
    super.initState();


    _firestoreService = TaskFirestoreService(widget.user.uid);
    _fetchTotalTasks();
  }

  void _fetchTotalTasks() async {
    try {
      List<Tasks> tasks = await _firestoreService.getTasks().first;
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
                            AppStrings.taskListPageText1,
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          8.h,
                          const Text(
                            AppStrings.taskListPageText2,
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
                    AssetPath.taskListPageImg,
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
  late TaskFirestoreService _firestoreService;
  int _currentIndex = 0; // Add this for bottom navigation

  @override
  void initState() {
    super.initState();

    _firestoreService = TaskFirestoreService(widget.user.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Tasks>>(
        stream: _firestoreService.getTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error loading tasks: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks found'));
          } else {
            List<Tasks> tasks = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
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
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
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
                                  SizedBox(width: 8),
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
                              SizedBox(height: 8),
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
                        SizedBox(height: 40),
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
                                color: AppColors.primaryColor,
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
      ),
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0, 3),
              blurRadius: 4,
            ),
          ],
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TitlePage(
                  user: widget.user,
                ),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          hoverColor: Colors.white,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: widget.currentIndex,
      onTap: widget.onTap,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 32.0,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            size: 32.0,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
