import 'package:accessment/app/utils/Extensions/size_box_extension.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:accessment/app/constants/app_colors.dart';
import 'package:accessment/app/components/custom_button.dart';
import 'package:accessment/app/components/custom_text_field.dart';
import 'package:accessment/app/components/custom_icon_button.dart';
import 'package:accessment/app/utils/common_widgets/or_divider_widget.dart';
import 'package:accessment/app/utils/common_widgets/register_login_link_widget.dart';
import 'package:accessment/app/constants/asset_paths.dart';
import '../../config/routes/routes.dart';
import '../provider/auth_provider.dart';
import '../services/auth_service.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  late bool _isObscured = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _isObscured;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  Future<void> _register(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      final authProvider = Provider.of<AuthProvider>(context,
          listen: false); // Obtain the provider

      try {
        await authProvider.registerUsingEmailPassword(
          name: nameController.text,
          email: emailController.text,
          password: passwordController.text,
          context: context,
        );
        Navigator.pushNamed(context, Routes.home, arguments: authProvider.user);
      } catch (e) {
        // Handle registration errors
        ScaffoldMessenger.of(context).showSnackBar(
          FireAuth.customSnackBar(content: e.toString()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginPage(),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Back to login",
          style: TextStyle(
            color: AppColors.primaryColor,
            fontFamily: "Inter",
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (context) => AuthProvider(), // Provide the AuthProvider
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Register",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.neutralBlackColor,
                                ),
                              ),
                              16.h,
                              const Text(
                                "And start taking note",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.neutralDarkGreyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        32.h,
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Full Name",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.neutralBlackColor,
                                ),
                              ),
                              12.h,
                              CustomTextField(
                                controller: nameController,
                                labelText: "Example: John Doe",
                                hintStyle: const TextStyle(
                                  color: AppColors.hintColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16,
                                  fontFamily: "Inter",
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Full name cannot be empty';
                                  }
                                  return null;
                                },
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
                              12.h,
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
                                  if (!RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w]{2,5}$')
                                      .hasMatch(value)) {
                                    return 'Invalid email';
                                  }
                                  return null;
                                },
                              ),
                              32.h,
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
                                  if (value.length < 6) {
                                    return 'Password should be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                              12.h,
                              const Text(
                                "Retype Password",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.neutralBlackColor,
                                ),
                              ),
                              12.h,
                              CustomTextField(
                                controller: retypePasswordController,
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
                                  if (value != passwordController.text) {
                                    return 'Passwords do not match';
                                  }
                                  return null;
                                },
                              ),
                              40.h,
                            ],
                          ),
                        ),
                        CustomButton(
                          text: 'Register',
                          onPressed: () => _register(context),
                          isLoading: authProvider.isLoading,
                        ),
                        16.h,
                        OrDivider(),
                        16.h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIconButton(
                              icon: AssetPath.googleIcon,
                              onPressed: authProvider.isLoading
                                  ? null
                                  : () async {
                                      final user = await authProvider
                                          .signInWithGoogle(context);

                                      if (authProvider.user != null) {
                                        Navigator.pushNamed(
                                            context, Routes.home,
                                            arguments: authProvider.user);
                                      }
                                    },
                              iconSize: const Size(29.55, 29.55),
                            ),
                            const SizedBox(width: 20),
                            CustomIconButton(
                              icon: AssetPath.facebook,
                              onPressed: () {},
                              iconSize: const Size(29.55, 29.55),
                            ),
                          ],
                        ),
                        16.h,
                        RegisterLoginLinkWidget(
                          route: () =>
                              Navigator.pushNamed(context, Routes.login),
                          text: "Login here",
                          preText: "Already have an account?",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
