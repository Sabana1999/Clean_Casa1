// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:casa_example/adminscreen.dart/dashboard.dart';
import 'package:casa_example/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Admin'),
            accountEmail: Text('Admin@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                  child: Image.asset(
                'asset/image/kli.jpeg',
                width: 300,
                fit: BoxFit.cover,
              )),
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://th.bing.com/th/id/OIP.XYqSkWGta-KMzOboZyq58gHaEK?w=326&h=183&c=7&r=0&o=5&dpr=1.3&pid=1.7'),
                    fit: BoxFit.cover)),
          ),
          ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('DashBoard'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardPage()));
              }),
          ListTile(
              leading: Icon(Icons.supervised_user_circle_outlined),
              title: Text('User List'),
              onTap: () {}),
          ListTile(
              leading: Icon(Icons.library_books_outlined),
              title: Text('Bookings'),
              onTap: () {}),
          ListTile(
              leading: Icon(Icons.info), title: Text('About'), onTap: () {}),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Logout Confirmation'),
                      content: Text('Do you want to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            final _sharedPrefs =
                                await SharedPreferences.getInstance();
                            await _sharedPrefs.clear();
                            // ignore: use_build_context_synchronously
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginForm()),
                              (route) =>
                                  false, // Prevents going back to the home page
                            );
                          },
                          child: const Text('Sign Out'),
                        ),
                      ],
                    );
                  });
            },
          )

          // Add more ListTile items or other widgets for your custom drawer
        ],
      ),
    );
  }
}
