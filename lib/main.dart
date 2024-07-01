// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'app/firebase_options.dart';
// import 'app/modules/view/login_page.dart';
// import 'app/modules/view/onboard_page.dart';
// import 'app/modules/view/register_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     name: "accessment",
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // User? user = FireAuth.u
//
//       // home: StreamBuilder<User?>(
//       home: StreamBuilder(
//         // stream: FirebaseAuth.instance.authStateChanges(),
//         stream: null,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.hasError) {
//             return Text(snapshot.error.toString());
//           }
//
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data == null) {
//               return LoginPage();
//             } else {
//
//               return RegisterPage();
//
//             }
//           }
//           // return Center(child: CircularProgressIndicator(),);
//
//           return OnboardingPage();
//         },
//       ),
//       // home: const LoginPage(),
//     );
//   }
// }


















// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'app/firebase_options.dart';
// import 'app/modules/provider/auth_provider.dart';
// import 'app/modules/view/login_page.dart';
// import 'app/modules/view/onboard_page.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     name: "accessment",
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => AuthProvider(),
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Consumer<AuthProvider>(
//         builder: (context, authProvider, child) {
//           if (authProvider.user == null) {
//             return const LoginPage();
//           } else {
//             return  OnboardingPage();
//           }
//         },
//       ),
//     );
//   }
// }









// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';
// import 'app/config/routes/routes.dart';
// import 'app/firebase_options.dart';
// import 'app/modules/provider/auth_provider.dart';
// import 'app/modules/provider/task_provider.dart';
// import 'app/modules/view/login_page.dart';
// import 'app/modules/view/onboard_page.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     name: "accessment",
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => AuthProvider()),
//         Consumer<AuthProvider>(
//           builder: (context, authProvider, _) {
//             return ChangeNotifierProvider<TaskFirestoreServiceProvider>(
//               create: (context) => TaskFirestoreServiceProvider(uid: authProvider.uid ?? ''),
//               // Note: Replace '' with default value or handle as per your app logic
//               child: const MyApp(),
//             );
//           },
//         ),
//         // Add other providers if needed
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//
//       ),
//
//       home: Consumer<AuthProvider>(
//         builder: (context, authProvider, child) {
//           if (authProvider.user == null) {
//             return const LoginPage();
//           } else {
//             return  OnboardingPage();
//           }
//         },
//       ),
//     );
//   }
// }
















// main.dart






import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:provider/provider.dart';
import 'package:accessment/app/config/routes/routes.dart';
import 'package:accessment/app/firebase_options.dart';
import 'package:accessment/app/modules/provider/auth_provider.dart';
import 'package:accessment/app/modules/provider/task_provider.dart';
import 'package:accessment/app/modules/view/login_page.dart';
import 'package:accessment/app/modules/view/onboard_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "accessment",
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Facebook Auth
  // await FacebookAuth.instance.webInitialize(
      await FacebookAuth.instance.webAndDesktopInitialize(
    appId: "YOUR_FACEBOOK_APP_ID",
    cookie: true,
    xfbml: true,
    version: "v10.0",
  );


  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) {
            return ChangeNotifierProvider<TaskFirestoreServiceProvider>(
              create: (context) => TaskFirestoreServiceProvider(uid: authProvider.uid ?? ''),
              child: const MyApp(),
            );
          },
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Routes.onboard,
      onGenerateRoute: Routes.generateRoute,

      home: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          if (authProvider.user == null) {
            return const LoginPage();
          } else {
            return  OnboardingPage();
          }
        },
      ),
    );
  }
}















