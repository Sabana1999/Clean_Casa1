// ac_service_functions.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:casa_example/adminscreen.dart/addcategory/db3.dart';
import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/inside_category.dart';

List<ServiceModel2> getMatchingCategories(ServiceModel1 serviceModel1) {
  final serviceBox = Hive.box<ServiceModel2>('service2');
  final String addedCategoryName = serviceModel1.heading.trim();

  return serviceBox.values
      .where((serviceModel2) => serviceModel2.category.trim() == addedCategoryName)
      .toList();
}

List<Widget> buildCategoryWidgets(BuildContext context, List<ServiceModel2> matchingCategories) {
  List<Widget> widgets = [];
  for (var matchingCategory in matchingCategories) {
    widgets.add(makeCategory(
      context: context,
      imagePath: matchingCategory.imagePath,
      title: matchingCategory.service,
    ));
  }

  return widgets;
}

Widget makeCategory({required BuildContext context, required String imagePath, required String title, subtitle}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FrontCategory1(imagePath: imagePath, title: title),
        ),
      );
    },
    child: AspectRatio(
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
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              colors: [
                Colors.black.withOpacity(.8),
                Colors.black.withOpacity(.0),
              ],
            ),
          ),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget makeCustodian({required String image, required String title}) {
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
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(.8),
              Colors.black.withOpacity(.0),
            ],
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ),
  );
}
