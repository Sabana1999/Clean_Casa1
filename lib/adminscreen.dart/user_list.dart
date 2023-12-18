import 'package:casa_example/color.dart';
import 'package:casa_example/databse/logind.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

// ignore: use_key_in_widget_constructors
class AdProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
                automaticallyImplyLeading: false,

        title: Text('User List'),
      ),
      body: FutureBuilder<Box<User>>(
        future: Hive.openBox<User>('users'), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final usersBox = snapshot.data!;
            final userList = usersBox.values.toList();

            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color:primary,
                  //Colors.primaries[index % Colors.primaries.length], // Use different primary colors for each card
                  elevation: 3,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      user.name ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      user.email ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Text(
                      user.number ?? '',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
