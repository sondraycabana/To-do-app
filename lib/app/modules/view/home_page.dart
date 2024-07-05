import 'package:assessment/app/modules/view/settings_screen.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../services/task_firestore_service.dart';
import '../view/title_page.dart';
import 'home_screen.dart';

class HomePage extends StatefulWidget {
  final dynamic user;
  const HomePage({super.key, required this.user});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late TaskFireStoreService fireStoreService;

  @override
  void initState() {
    super.initState();

    fireStoreService = TaskFireStoreService(widget.user.uid);
  }

  int _currentIndex = 0;
  final List<Widget> _children = [
    const HomeScreen(),
    const SettingsScreen(),
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
              size: 32.0,
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

          backgroundColor: AppColors.primaryColor,
          hoverColor: Colors.white,
          elevation: 5, // Adjust the elevation as needed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
