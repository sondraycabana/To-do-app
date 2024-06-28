import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../components/custom_button.dart';
import '../../components/custom_icon_button.dart';
import '../../components/custom_text_field.dart';
import '../../config/routes/routes.dart';
import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';
import '../../utils/common_widgets/or_divider_widget.dart';
import '../../utils/common_widgets/register_login_link_widget.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageScreen();
}

class _LoginPageScreen extends State<LoginPage> {
  final FireAuth fireAuth = FireAuth();
  bool isLoading = false;
  late bool _isObscured = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isObscured;
  }

  void _login() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await FireAuth.signInUsingEmailPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (user != null) {
        Navigator.pushNamed(context, Routes.home, arguments: user);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          FireAuth.customSnackBar(content: "Invalid credentials"),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        FireAuth.customSnackBar(content: e.toString()),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _loginWithGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await FireAuth.signInWithGoogle(context);

      if (user != null) {
        Navigator.pushNamed(context, Routes.home, arguments: user);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        FireAuth.customSnackBar(content: e.toString()),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  101.h,
                  const Text(
                    "Let's Login",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF180E25),
                    ),
                  ),
                  16.h,
                  const Text(
                    "And note your ideas",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0XFF827D89),
                    ),
                  ),
                ],
              ),
              32.h,
              const Text(
                "Email Address",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralBlackColor,
                ),
              ),
              10.h,
              CustomTextField(
                controller: emailController,
                labelText: "Example: johndoe@gmail.com",
                hintStyle: const TextStyle(
                  fontFamily: "Inter",
                  color: AppColors.hintColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email cannot be empty';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,5}$')
                      .hasMatch(value)) {
                    return 'Invalid email';
                  }
                  return null;
                },
              ),
              15.h,
              const Text(
                "Password",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.neutralBlackColor,
                ),
              ),
              12.h,
              CustomTextField(
                controller: passwordController,
                labelText: "********",
                obscureText: true,
                hintStyle: const TextStyle(
                  fontFamily: "Inter",
                  color: AppColors.hintColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password cannot be empty';
                  }
                  return null;
                },
              ),
              12.h,
              GestureDetector(
                onTap: () {},
                child: RichText(
                  text: const TextSpan(

                    text: 'Forgot password',
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              40.h,
              CustomButton(
                text: 'Login',
                onPressed: _login,
                isLoading: isLoading,
              ),
              31.h,
              const OrDivider(),
              16.h,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    icon: AssetPath.googleIcon,
                    onPressed: isLoading ? null : _loginWithGoogle,
                    iconSize: const Size(29.55, 29.55),
                  ),
                  20.w,
                  CustomIconButton(
                    icon: AssetPath.facebook,
                    onPressed: isLoading ? null : _loginWithGoogle,
                    iconSize: Size(29.55, 29.55),
                  ),
                ],
              ),
              16.h,
              RegisterLoginLinkWidget(
                route: () => Navigator.pushNamed(context, Routes.register),
                text: 'Register here',
                preText: "Don't have an account?",
              ),
            ],
          ),
        ),
      ),
    );
  }
}