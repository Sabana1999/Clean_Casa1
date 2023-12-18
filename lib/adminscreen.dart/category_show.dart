// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';
import 'package:casa_example/adminscreen.dart/adddeatils.dart/db5.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/db4.dart';
import 'package:casa_example/adminscreen.dart/price_edit.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class FrontCategory2 extends StatefulWidget {
  final String imagePath;
  final String title;

  const FrontCategory2({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FrontCategory1State createState() => _FrontCategory1State();
}

class _FrontCategory1State extends State<FrontCategory2> {
  Future<List<ServiceModel4>> _getServiceDetailsModel4(String title) async {
    final service4Box = Hive.box<ServiceModel4>('service4');
    List<ServiceModel4> allServices = service4Box.values.toList();
    return allServices.where((service) => service.service == title).toList();
  }

  Future<List<ServiceModel3>> _getServiceDetails(String title) async {
    final serviceBox = await Hive.openBox<ServiceModel3>('service3');
    List<ServiceModel3> allServices = serviceBox.values.toList();
    return allServices.where((service) => service.title == title).toList();
  }

  // ignore: unused_element
  void _updateServiceModel4(ServiceModel4 service) {
    final service4Box = Hive.box<ServiceModel4>('service4');
    service4Box.put(service.key, service);
  }

  void deleteBulletItem(int index, String title) async {
    final service4Box = Hive.box<ServiceModel4>('service4');

    List<ServiceModel4> items = service4Box.values.toList();
    for (var i = 0; i < items.length; i++) {
      if (items[i].service == title) {
        if (index == 0 &&
            // ignore: unnecessary_null_comparison
            items[i].details1 != null &&
            items[i].details1.isNotEmpty) {
          items[i].details1 = '';

        // ignore: unnecessary_null_comparison
        }else if(index==1 && items[i].details2!=null && items[i].details2.isNotEmpty){
                    items[i].details2 = '';

        }
        service4Box.put(items[i].key, items[i]);
      }
      setState(() {
        
      });
    }
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
                                  style: TextStyle(
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
              SizedBox(height: 20),
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
                                  Row(
                                    children: [
                                      Text(
                                        'Rs: ${snapshot.data![0].price}',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () async {
                                          var updatedPrice =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PriceEdit(
                                                currentPrice:
                                                    snapshot.data![0].price,
                                              ),
                                            ),
                                          );

                                          if (updatedPrice != null &&
                                              updatedPrice is String) {
                                            setState(() {
                                              snapshot.data![0].price =
                                                  updatedPrice;
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.edit),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              // Inside _FrontCategory1State class
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
                                                        text: service.details1,
                                                        onDelete: () {
                                                          deleteBulletItem(
                                                              0, widget.title);

                                                          // Delete functionality for details1 bullet

                                                          //_removeServiceModel4(
                                                          //  service.key);
                                                          // _deleteServiceModel4(
                                                          //     service.key);
                                                        },
                                                        index: 0,
                                                      ),
                                                    // ignore: unnecessary_null_comparison
                                                    if (service.details2 !=
                                                            null &&
                                                        service.details2
                                                            .isNotEmpty)
                                                      BulletPoint(
                                                        text: service.details2,
                                                        onDelete: () {
                                                          deleteBulletItem(
                                                              1, widget.title);

                                                          // Delete functionality for details2 bullet

                                                          // _deleteServiceModel4(
                                                          //     service.key);
                                                          // _removeServiceModel4(
                                                          // service.key);
                                                        },
                                                        index: 1,
                                                      ),
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
            ],
          ),
        ),
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;
  final int index;
  final VoidCallback onDelete;

  const BulletPoint({
    required this.text,
    required this.onDelete,
    required this.index,
  });

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
