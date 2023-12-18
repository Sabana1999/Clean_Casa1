import 'package:casa_example/color.dart';
import 'package:flutter/material.dart';

// Define your primary color
//const Color primaryColor = primar // Replace with your desired primary color

class FirstHelp extends StatefulWidget {
  const FirstHelp({Key? key}) : super(key: key);

  @override
  State<FirstHelp> createState() => _FirstHelpState();
}

class _FirstHelpState extends State<FirstHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book a Service'),
        backgroundColor: primary, // Apply primary color to the app bar
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        children: [
          _buildHelpItem(
            '1. Select the service you want to book.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '2. Select the service category based on your need.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '3. On details page, click add button. Added item will show on cart page.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '4. Click "Book Now" button. It will redirect to the booking page. Provide information and click submit button.',
            Icons.check_circle,
          ),
          _buildHelpItem(
            '5. The booking details will show on the bookings page. Now, the booking is completed.',
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
