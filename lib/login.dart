import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'signup.dart';
import 'displayNotes.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    final response = await http.post(
      Uri.parse('https://insuppressible-gras.000webhostapp.com/login.php'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      print('Login successful');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DisplayNotesScreen()),
      );
    } else {
      print('Login failed. ${response.body}');
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _handleLogin,
              child: Text('Login'),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account?"),
                TextButton(
                  onPressed: _navigateToSignUp,
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}