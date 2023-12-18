// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:io';
import 'package:casa_example/adminscreen.dart/addcategory/category_function.dart';
import 'package:flutter/material.dart';
import 'package:casa_example/adminscreen.dart/addcategory/db3.dart';
import 'package:casa_example/adminscreen.dart/additem/db2.dart';

class AcService extends StatefulWidget {
  final ServiceModel1 serviceModel1;

  const AcService({super.key, 
    required this.serviceModel1,
    required String imagePath,
    required String heading,
    required String description,
  });

  @override
  State<AcService> createState() => _CleaningServiceState();
}

class _CleaningServiceState extends State<AcService> {
  late List<ServiceModel2> matchingCategories;

  @override
  void initState() {
    super.initState();
    matchingCategories = getMatchingCategories(widget.serviceModel1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 500,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(widget.serviceModel1.imagePath)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
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
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.serviceModel1.heading,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              widget.serviceModel1.description,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Categories',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: buildCategoryWidgets(context, matchingCategories),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          makeCustodian(
                            image: 'asset/image/Premium Vector _ Modern welcome lettering design.jpeg',
                            title: 'First-Time Customer Discount\nNew to us? Get 10% off your first  service! Start your journey with us today',
                          ),
                          makeCustodian(
                            image: 'asset/image/Promotion Special Offer Vector Design Images, Super  And Special Offer   Design, Marketing, Redandorange, Offer PNG Image For Free Download.jpeg',
                            title: 'Recurring Service Discount\nSign up for a weekly or bi-weekly plan and save 15% on each service. Maintain a spotless home year-round',
                          ),
                          makeCustodian(
                            image: 'asset/image/offer.jpeg',
                            title: 'Holiday Prep Package\nGet your home ready for the holidays stress-free. Book our Holiday Prep Package and save 30%',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
