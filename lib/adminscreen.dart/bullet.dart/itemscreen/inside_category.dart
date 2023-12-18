// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:casa_example/adminscreen.dart/adddeatils.dart/db5.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/db4.dart';
import 'package:casa_example/adminscreen.dart/price_edit.dart';
import 'package:casa_example/color.dart';
import 'package:casa_example/userscreen/cart/cardb.dart';
import 'package:casa_example/userscreen/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FrontCategory1 extends StatefulWidget {
  final String imagePath;
  final String title;

  const FrontCategory1({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FrontCategory1State createState() => _FrontCategory1State();
}

class _FrontCategory1State extends State<FrontCategory1> {
  String updatedPrice='';

   // navigate to PriceEdit screen 
  // ignore: unused_element
  Future<void> _navigateToPriceEdit() async {
    final editedPrice = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PriceEdit(currentPrice: updatedPrice),
      ),
    );

    if (editedPrice != null) {
      setState(() {
        updatedPrice = editedPrice; // Update the edited price
      });
    }
  }

  Future<List<ServiceModel4>> 
  _getServiceDetailsModel4(String title) async {
    final service4Box = Hive.box<ServiceModel4>('service4');
    List<ServiceModel4> allServices = service4Box.values.toList();
    return allServices.where((service) => service.service == title).toList();
  }

  Future<List<ServiceModel3>> _getServiceDetails(String title) async {
    final serviceBox = await Hive.openBox<ServiceModel3>('service3');
    List<ServiceModel3> allServices = serviceBox.values.toList();
    return allServices.where((service) => service.title == title).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(widget.imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(.9),
                        Colors.black.withOpacity(.2),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CartPage())); //crt nv
                            },
                            icon:
                                Icon(Icons.shopping_cart, color: Colors.white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<List<ServiceModel3>>(
                future: _getServiceDetails(widget.title),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    ' Rs:${snapshot.data![0].price}',   
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              FutureBuilder<List<ServiceModel4>>(
                                future: _getServiceDetailsModel4(widget.title),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            for (var service in snapshot.data!)
                                              if (service.service ==
                                                  widget.title)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // ignore: unnecessary_null_comparison
                                                    if (service.details1 !=
                                                            null &&
                                                        service.details1
                                                            .isNotEmpty)
                                                      BulletPoint(
                                                          service.details1),
                                                    // ignore: unnecessary_null_comparison
                                                    if (service.details2 !=
                                                            null &&
                                                        service.details2
                                                            .isNotEmpty)
                                                      BulletPoint(
                                                          service.details2),
                                                  ],
                                                ),
                                          ],
                                        );
                                      } else {
                                        return Text(
                                            'No details available for this service.');
                                      }
                                    }
                                  } else {
                                    return CircularProgressIndicator();
                                  }
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Text('No details available for this service.');
                      }
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(height: 130),
              ElevatedButton(
                onPressed: () async {
                  List<ServiceModel3> serviceDetails =
                      await _getServiceDetails(widget.title);
                  if (serviceDetails.isNotEmpty) {
                    // Assuming price information in serviceDetails
                    String price = serviceDetails[0]
                        .price
                        .toString(); 
                    String bulletDetails = '';

                    // Create a Cart object
                    Cart cartItem = Cart(
                      widget.title,
                      bulletDetails,
                      price,
                      widget.imagePath,
                    );

                    var cartBox = await Hive.openBox<Cart>('cart');
                    // cartBox.add(cartItem);
                    bool isItem = cartBox.values
                        .any((element) => element.title == cartItem.title);
                    if (isItem) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Item is already in the cart'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    } else {
                      cartBox.add(cartItem);
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Item added to the cart'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to add item to cart'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    fixedSize: Size(300, 45),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                child: Text('Add To Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  BulletPoint(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 8.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 14.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
