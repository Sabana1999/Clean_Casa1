// ignore_for_file: use_key_in_widget_constructors

import 'package:casa_example/color.dart';
import 'package:casa_example/userscreen/about_us.dart';
import 'package:flutter/material.dart';

class UserAccount extends StatefulWidget {
  const UserAccount({Key? key});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        centerTitle: true,
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage('asset/image/Instagram Crush_ Julia Knezevic (23 Photos).jpeg'),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            buildListTile(Icons.person, 'Name', 'Dabra'),
            buildListTile(Icons.email, 'Email Address', 'Dabra@example.com'),
            buildListTile(Icons.phone_android, 'Phone Number', '+123456789'),
              ListTile(
              leading: Icon(
                Icons.info,
                size: 32,
                color: primary,
              ),
              title: Text(
                'About Us',
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUsPage()),
                );
              },
            ),
           
          ],
        ),
      ),
    );
  }

  Widget buildListTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32,
        color: primary,
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 14),
      ),
    );
  }
}
