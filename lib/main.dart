import 'package:flutter/material.dart';
import 'package:possi_build/NavigationPage.dart';
import 'package:possi_build/screens/SigninPage.dart';
import 'package:possi_build/screens/SignupPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: const Color(0xff000000),
              displayColor: const Color(0xffffffff))),
      home: SignIn(),
      // SignIn(),
      routes: {
        '/signin': (context) => const SignIn(),
        '/signup': (context) => const SignUp(),
      },
    );
  }
}
