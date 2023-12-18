import 'package:casa_example/color.dart';
import 'package:flutter/material.dart';

// Define your primary color

class SecondHelp extends StatefulWidget {
  const SecondHelp({Key? key}) : super(key: key);

  @override
  State<SecondHelp> createState() => _SecondHelpState();
}

class _SecondHelpState extends State<SecondHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add another account'),
        backgroundColor: primary, // Apply primary color to the app bar
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          _buildHelpItem(
            '1. First of all, log out of your current account that you signed in.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '2. Go to the user account screen. There you can see the logout button.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '3. Sign in with the new username and phone number.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '4. Then log in with the registered username and password.',
            Icons.check_circle,
          ),
        ],
      ),
    );
  }

  Widget _buildHelpItem(String text, IconData icon) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(
          icon,
          color: primary,
        ),
        title: Text(
          text,
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
