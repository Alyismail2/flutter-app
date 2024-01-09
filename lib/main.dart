import 'package:flutter/material.dart';
import 'signup.dart';
import 'login.dart';
import 'displayNotes.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/displayNotes': (context) => DisplayNotesScreen(),
      },
    );
  }
}