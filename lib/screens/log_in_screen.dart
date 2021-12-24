import 'package:flutter/material.dart';

import './news_screen.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Log In'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsScreen()),
            );
          },
        ),
      ),
    );
  }
}
