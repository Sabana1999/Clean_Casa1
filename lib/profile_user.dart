// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:casa_example/color.dart';
import 'package:casa_example/login.dart';
import 'package:casa_example/userscreen/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileUs extends StatefulWidget {
  const ProfileUs({super.key});

  @override
  State<ProfileUs> createState() => _ProfileUsState();
}

class _ProfileUsState extends State<ProfileUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                automaticallyImplyLeading: false,

        backgroundColor: Colors.white,
        title: Text(
          'Account',
          style: TextStyle(color: primary),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(70),
                      image: DecorationImage(
                          image: AssetImage(
                            'asset/image/WhatsApp Image 2023-11-25 at 22.42.43_ef50d294.jpg',
                          ),
                          fit: BoxFit.cover)),
                ),
                Expanded(
                    child: ListTile(
                  title: Text('Clean Casa  ', style: TextStyle(color: primary)),
                  subtitle: Text('Homeservices in your finger tips'),
                )),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                color: primary,
              ),
              title: Text('Profile'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => UserAccount()));
                  },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.no_accounts_sharp,
                color: primary,
              ),
              title: Text('Delete Account'),
              trailing: IconButton(
                  onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Account delete Confirmation'),
                        content: Text('Are you sure you want to delete this account?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final _sharedPrefs = await SharedPreferences.getInstance();
                              await _sharedPrefs.clear();
                              // Navigate back to login page
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginForm(),
                                ),
                                (route) => false, // Prevents going back to the home page
                              );
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );
                },
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
          ),Divider(thickness: 1,),



          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.policy,
                color: primary,
              ),
              title: Text('Legal and Policies'),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
          ),
          
          Divider(
            thickness: 1,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: ListTile(
              leading: Icon(
                Icons.color_lens,
                color: primary,
              ),
              title: Text('Theme'),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_forward_ios_outlined)),
            ),
          ),
          
          
          
          Divider(thickness: 1,),
          
           Container(
            padding: EdgeInsets.all(10),
             child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 32,
                  color: primary,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(fontSize: 16),
                ),
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
                              final _sharedPrefs = await SharedPreferences.getInstance();
                              await _sharedPrefs.clear();
                              // Navigate back to login page
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginForm(),
                                ),
                                (route) => false, // Prevents going back to the home page
                              );
                            },
                            child: const Text('Sign Out'),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
           ),
        ],
      ),
    );
  }
}
