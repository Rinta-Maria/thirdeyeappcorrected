import 'package:flutter/material.dart';
import 'package:thireyeapp/pages/loginpage.dart';
import 'package:thireyeapp/pages/logout.dart';
import 'package:thireyeapp/pages/profile.dart';
import 'package:thireyeapp/pages/settings.dart';
import 'package:thireyeapp/pages/signup.dart';
import 'package:thireyeapp/pages/spects.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:thireyeapp/pages/splash.dart';

import 'package:thireyeapp/pages/profile.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android); // Initialize Firebase
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen Demo',
      theme: ThemeData(
        primarySwatch:Colors.grey,

      ),
      home:SplashScreen(),
      routes: {
        '/signin':(context) => SignUpPage(),
        '/login': (context) => LoginPage(),
        '/logout':(context) => LogoutPage(),
        '/splash':(context) => SplashScreen(),


        

      },

      ); // Set SplashScreen as the initial screen
    
  }
}
