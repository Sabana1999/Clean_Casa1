import 'dart:io';

import 'package:casa_example/adminscreen.dart/booking_show.dart';
import 'package:casa_example/userscreen/address/addb.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore: use_key_in_widget_constructors
class AdBokking extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _UserBookingState createState() => _UserBookingState();
}

class _UserBookingState extends State<AdBokking> {
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
                          builder: (context) => InsideBk1(
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
                          // ignore: unnecessary_string_interpolations
                          '${address.title ?? 'No Title'}',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
}
