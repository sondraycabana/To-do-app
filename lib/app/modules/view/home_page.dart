import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accessment/app/modules/provider/task_provider.dart';
import 'package:accessment/app/constants/app_colors.dart';
import 'package:accessment/app/modules/view/settings_screen.dart';
import '../view/title_page.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  final user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TaskFirestoreServiceProvider _firestoreService; // Declare TaskFirestoreService instance

  @override
  void initState() {
    super.initState();
    // Access TaskFirestoreService instance from provider
    _firestoreService = Provider.of<TaskFirestoreServiceProvider>(context, listen: false);

    if (widget.user != null) {
      _firestoreService = TaskFirestoreServiceProvider(uid: widget.user.uid);
    } else {
      if (kDebugMode) {
        print("User is not available");
      }
    }
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
              size: 32.0, // Set icon size to 32
            ),
            label: 'Settings',
          ),
        ],
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
          elevation: 5, // Adjust the elevation as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
