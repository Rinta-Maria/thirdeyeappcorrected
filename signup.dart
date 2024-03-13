import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thireyeapp/components/my_button.dart';
import 'package:thireyeapp/components/my_button2.dart';
import 'package:thireyeapp/components/my_textfield.dart';
import 'package:thireyeapp/pages/spects.dart'; // Assuming MyHomePage is defined in this import
import 'package:thireyeapp/pages/loginpage.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key});

  // Firebase authentication instance
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // navigate to HomePage on successful signup
  void navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>MyHomePage ()),
    );
  }

  // navigate to LoginPage on signup failure
  void navigateToLogin(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  // show error dialog
  void showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // validate email format
  bool isEmailValid(String email) {
    String emailRegex = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(emailRegex);
    return regex.hasMatch(email);
  }

  // sign up method
  Future<void> signUpUser(BuildContext context) async {
    try {
      if (emailController.text.trim().isEmpty ||
          passwordController.text.isEmpty) {
        showErrorDialog(context, 'Please enter both email and password.');
        return;
      }

      if (!isEmailValid(emailController.text.trim())) {
        showErrorDialog(context, 'Please enter a valid email address.');
        return;
      }

      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      // If sign up is successful, navigate to the homepage
      navigateToHome(context);
      print("User signed up: ${userCredential.user?.email}");
    } catch (e) {
      // Handle sign up errors
      print("Error during sign up: $e");
      showErrorDialog(
          context, 'Sign up failed. Please check your email and password.');
      // If signup fails, navigate to the login page
      navigateToLogin(context);
    }
  }

  // sign up with Google method
  Future<void> signUpWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      // If sign up with Google is successful, navigate to the homepage
      navigateToHome(context);
      print("User signed up with Google: ${userCredential.user?.displayName}");
    } catch (e) {
      // Handle sign up errors
      print("Error during Google sign up: $e");
      showErrorDialog(context, 'Sign up with Google failed.');
      // If signup fails, navigate to the login page
      navigateToLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Column(
        children: [
          TextField(controller: emailController, decoration:
            InputDecoration(labelText:'Email')),
          TextField(controller:
            passwordController, decoration:
            InputDecoration(labelText:'Password')),
          ElevatedButton(onPressed:
            () => signUpUser(context), child:
            Text('Sign Up')),
          ElevatedButton(onPressed:
            () => signUpWithGoogle(context), child:
            Text('Sign Up with Google'))
        ],
      ),
    );
  }
}
