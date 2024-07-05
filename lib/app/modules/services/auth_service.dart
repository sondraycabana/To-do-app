// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../view/login_page.dart';
//
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final GoogleSignIn _googleSignIn = GoogleSignIn();
//
// class FireAuth {
//   static Future<User?> registerUsingEmailPassword({
//     required String name,
//     required String email,
//     required String password, required BuildContext context,
//   }) async {
//     User? user;
//     try {
//       UserCredential userCredential =
//       await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       user = userCredential.user;
//       await user!.updateProfile(displayName: name);
//       await user.reload();
//       user = _auth.currentUser;
//     } on FirebaseAuthException catch (e) {
//       throw _handleAuthException(e);
//     } catch (e) {
//       throw Exception("An unknown error occurred: $e");
//     }
//     return user;
//   }
//
//   static Future<User?> signInUsingEmailPassword({
//     required String email,
//     required String password,
//   }) async {
//     User? user;
//     try {
//       UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       user = userCredential.user;
//     } on FirebaseAuthException catch (e) {
//       throw _handleAuthException(e);
//     } catch (e) {
//       throw Exception("An unknown error occurred: $e");
//     }
//     return user;
//   }
//
//   static Future<void> signOut(BuildContext context) async {
//     await _auth.signOut();
//     await _googleSignIn.signOut();
//
//     Navigator.of(context).pushAndRemoveUntil(
//       MaterialPageRoute(builder: (context) => const LoginPage()),
//           (route) => false,
//     );
//   }
//
//   static Future<User?> signInWithGoogle(BuildContext context) async {
//     User? user;
//     try {
//       final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
//
//       if (googleSignInAccount != null) {
//         final GoogleSignInAuthentication googleSignInAuthentication =
//         await googleSignInAccount.authentication;
//
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: googleSignInAuthentication.accessToken,
//           idToken: googleSignInAuthentication.idToken,
//         );
//
//         final UserCredential userCredential =
//         await _auth.signInWithCredential(credential);
//         user = userCredential.user;
//       }
//     } on FirebaseAuthException catch (e) {
//       throw _handleAuthException(e);
//     } catch (e) {
//       throw Exception("An unknown error occurred: $e");
//     }
//     return user;
//   }
//
//   static Future<User?> refreshUser(User user) async {
//     await user.reload();
//     return _auth.currentUser;
//   }
//
//   static Exception _handleAuthException(FirebaseAuthException e) {
//     switch (e.code) {
//       case 'weak-password':
//         return Exception('The password provided is too weak.');
//       case 'email-already-in-use':
//         return Exception('The account already exists for that email.');
//       case 'invalid-credential':
//         return Exception('Error occurred while accessing credentials. Try again.');
//       case 'account-exists-with-different-credential':
//         return Exception('The account already exists with a different credential.');
//       default:
//         return Exception('Authentication error: ${e.message}');
//     }
//   }
//
//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.red,
//       content: Text(
//         content,
//         style: const TextStyle(color: Colors.white, letterSpacing: 0.5),
//       ),
//     );
//   }
//
//
//   static Future<User?> signInWithFacebook() async {
//     try {
//       final LoginResult loginResult = await FacebookAuth.instance.login();
//
//       if (loginResult.status == LoginStatus.success) {
//         final AccessToken accessToken = loginResult.accessToken!;
//         final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.tokenString);
//         final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//         return userCredential.user;
//       } else {
//         throw FirebaseAuthException(
//           code: 'Facebook Login Failed',
//           message: 'The Facebook login was not successful.',
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       // Handle Firebase authentication exceptions
//       print('Firebase Auth Exception: ${e.message}');
//     }
//
//
//     }}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../view/login_page.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    User? user;
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = _auth.currentUser;
    } on FirebaseAuthException catch (e) {
      throw handleAuthException(e);
    } catch (e) {
      throw Exception("An unknown error occurred: $e");
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage = handleAuthException(e);
      throw Exception(errorMessage); // Throw a custom exception message
    } catch (e) {
      throw Exception("An unknown error occurred: $e");
    }
  }

  static Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await _googleSignIn.signOut();

    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginPage()),
          (route) => false,
    );
    }
  }

  static Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        return userCredential.user;
      } else {
        throw Exception("Google sign in canceled or failed");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = handleAuthException(e);
      throw Exception(errorMessage); // Throw a custom exception message
    } catch (e) {
      throw Exception("An unknown error occurred: $e");
    }
  }

  static Future<User?> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.status == LoginStatus.success) {
        final AccessToken accessToken = loginResult.accessToken!;
        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        return userCredential.user;
      } else {
        throw Exception("Facebook login failed");
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = handleAuthException(e);
      throw Exception(errorMessage); // Throw a custom exception message
    } catch (e) {
      throw Exception("An unknown error occurred: $e");
    }
  }

  static String handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'Invalid email address.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'network-request-failed':
        return 'Network error occurred. Please check your internet connection.';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        content,
        style: const TextStyle(color: Colors.white, letterSpacing: 0.5),
      ),
    );
  }
}
