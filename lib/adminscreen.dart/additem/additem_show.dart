import 'dart:io';
import 'package:casa_example/adminscreen.dart/addcategory/db3.dart';
import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/category_show.dart';
import 'package:casa_example/adminscreen.dart/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AcService1 extends StatefulWidget {
  final ServiceModel1 serviceModel1;

  // ignore: use_key_in_widget_constructors
  const AcService1({
    required this.serviceModel1,
    required String imagePath,
    required String heading,
    required String description,
  });

  @override
  State<AcService1> createState() => _CleaningServiceState();
}

class _CleaningServiceState extends State<AcService1> {
  late List<ServiceModel2> matchingCategories;
  String editedHeading = '';
  String editedDescription = '';
  File? editedImageFile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload data or update state 
    setState(() {
      editedHeading = widget.serviceModel1.heading;
      editedDescription = widget.serviceModel1.description;
      editedImageFile = File(widget.serviceModel1.imagePath);
      matchingCategories = _getMatchingCategories();
    });
  }

  @override
  void initState() {
    super.initState();
    matchingCategories = _getMatchingCategories();
    editedHeading = widget.serviceModel1.heading;
    editedDescription = widget.serviceModel1.description;
    editedImageFile = File(widget.serviceModel1.imagePath);
  }
//retrieves a list of ServiceModel2 objects from a Hive box
  List<ServiceModel2> _getMatchingCategories() {
    final serviceBox = Hive.box<ServiceModel2>('service2');
    final String addedCategoryName = widget.serviceModel1.heading.trim();

    return serviceBox.values
        .where((serviceModel2) =>
            serviceModel2.category.trim() == addedCategoryName)
        .toList();
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
                    image: FileImage(editedImageFile!
                        //File(widget.serviceModel1.imagePath)
                        ),
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
                            onPressed: () async {
                              final Map<String, dynamic>? result =
                                  await Navigator.push<Map<String, dynamic>>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditScreen(
                                    heading: editedHeading,
                                    description: editedDescription,
                                    imagePath: editedImageFile?.path ?? '',
                                  ),
                                ),
                              );

                              if (result != null) {
                                _updateEditedData(result);
                              }
                            },
                            icon: Icon(
                              Icons.edit,
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
                              editedHeading,
                              //widget.serviceModel1.heading,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              editedDescription,
                              // widget.serviceModel1.description,
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
                      children: const <Widget>[
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
                        children: _buildCategoryWidgets(),
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
                            image:
                                'asset/image/Premium Vector _ Modern welcome lettering design.jpeg',
                            title:
                                'First-Time Customer Discount\nNew to us? Get 10% off your first  service! Start your journey with us today',
                          ),
                          makeCustodian(
                            image:
                                'asset/image/Promotion Special Offer Vector Design Images, Super  And Special Offer   Design, Marketing, Redandorange, Offer PNG Image For Free Download.jpeg',
                            title:
                                'Recurring Service Discount\nSign up for a weekly or bi-weekly plan and save 15% on each service. Maintain a spotless home year-round',
                          ),
                          makeCustodian(
                            image: 'asset/image/offer.jpeg',
                            title:
                                'Holiday Prep Package\nGet your home ready for the holidays stress-free. Book our Holiday Prep Package and save 30%',
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

  List<Widget> _buildCategoryWidgets() {
    List<Widget> widgets = [];
    // ignore: unnecessary_null_comparison
    if (matchingCategories != null) {
      for (var i = 0; i < matchingCategories.length; i++) {
        widgets.add(makeCategory(
          imagePath: matchingCategories[i].imagePath,
          title: matchingCategories[i].service,
          index: i,
        ));
      }
    }

    return widgets;
  }

  Widget makeCategory(
      {required String imagePath, required String title, required int index}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FrontCategory2(imagePath: imagePath, title: title)));
      },
      child: Stack(
        children: [
          AspectRatio(
            aspectRatio: 3 / 2.2,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient:
                      LinearGradient(begin: Alignment.bottomRight, colors: [
                    Colors.black.withOpacity(.8),
                    Colors.black.withOpacity(.0),
                  ]),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                onDeleteCategory(index);
              },
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onDeleteCategory(int index) {
    setState(() {
      final serviceBox = Hive.box<ServiceModel2>('service2');
      final ServiceModel2 deletedCategory = serviceBox.getAt(index)!;

      serviceBox.deleteAt(index);

      final service1Box = Hive.box<ServiceModel1>('service1');
      service1Box.values
          .where((serviceModel1) =>
              serviceModel1.heading.trim() == deletedCategory.category.trim())
          .toList()
          .forEach((serviceModel1) {
        service1Box.delete(serviceModel1.key); //key to delete
      });

      matchingCategories = _getMatchingCategories();
    });
  }

  Widget makeCustodian({image, title}) {
    return AspectRatio(
      aspectRatio: 5 / 2.2,
      child: Container(
        margin: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.0),
            ]),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  void _updateEditedData(Map<String, dynamic> updatedData) {
    setState(() {
      editedHeading = updatedData['heading'];
      editedDescription = updatedData['description'];
      editedImageFile = updatedData['imageFile'] != null
          ? File(updatedData['imageFile'].path)
          : null;
    });
  }
}
