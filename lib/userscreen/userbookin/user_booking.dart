// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, unnecessary_string_interpolations

import 'dart:io';
import 'package:casa_example/userscreen/address/addb.dart';
import 'package:casa_example/userscreen/userbookin/user_bookin.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserBooking extends StatefulWidget {
  @override
  _UserBookingState createState() => _UserBookingState();
}

class _UserBookingState extends State<UserBooking> {
  late Box<Address> addressBox;

  @override
  void initState() {
    super.initState();
    addressBox = Hive.box<Address>('addressBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('User Bookings'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ValueListenableBuilder(
          valueListenable: addressBox.listenable(),
          builder: (context, Box<Address> box, _) {

            if(box.isEmpty){
              return Center(
                child: Image.asset('asset/image/undraw_Confirmation_re_b6q5.png'),
              );
            }
            return ListView.builder(
              itemCount: box.length,
              itemBuilder: (context, index) {
                Address address = box.getAt(index)!;
                return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InsideBk(
                            selectedIndex: index,
                            imagePath: address.imagePath ?? '',
                            title: address.title ?? 'No Title',
                            price: address.price ?? '',
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        leading: address.imagePath != null &&
                                address.imagePath!.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.file(
                                  File(address.imagePath!),
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(Icons.image), 
                        title: Text(
                          '${address.title ?? 'No Title'}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        trailing: PopupMenuButton<String>(
                          onSelected: (value) {
                            if (value == 'cancel') {
                              _showCancelDialog(index);
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              value: 'cancel',
                              child: ListTile(
                                leading: Icon(Icons.cancel),
                                title: Text('Cancel Booking'),
                              ),
                            ),
                          ],
                          icon: Icon(Icons.more_vert),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(int index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cancel Booking'),
          content: SingleChildScrollView(
            child: ListBody(
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                Text('Are you sure you want to cancel this booking?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                addressBox.deleteAt(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
