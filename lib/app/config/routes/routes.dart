// routes.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../modules/view/home_page.dart';
import '../../modules/view/login_page.dart';
import '../../modules/view/onboard_page.dart';
import '../../modules/view/register_page.dart';
import '../../modules/view/settings_screen.dart';
import '../../modules/view/task_list_page.dart';
import '../../modules/view/title_page.dart';

class Routes {
  static const String login = '/';
  static const String onboard = '/onboard';
  static const String register = '/register';
  static const String home = '/home';
  static const String taskListPage = '/taskListPage';
  static const String titlePage = '/titlePage';
  static const String setting = '/setting';




  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case onboard:
        return MaterialPageRoute(builder: (_) =>  const OnBoardingPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
        return MaterialPageRoute(builder: (_) => HomePage(user: settings.arguments as User));
      case taskListPage:
        return MaterialPageRoute(builder: (_) => TaskListPage( user: settings.arguments as User));

      case titlePage:
        return MaterialPageRoute(builder: (_) => const TitlePage(user:  User));
      case setting:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return null;
    }
  }
}
