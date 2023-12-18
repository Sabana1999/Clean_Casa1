// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:casa_example/adminscreen.dart/addcategory/db3.dart';
import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/addcategory/item.dart';
import 'package:casa_example/adminscreen.dart/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddHorizontal extends StatefulWidget {
  const AddHorizontal({Key? key}) : super(key: key);

  @override
  State<AddHorizontal> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddHorizontal> {
  XFile? _image;
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _serviceController = TextEditingController();

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.all(25),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2.0),
                ),
                child: _image == null
                    ? Center(
                        child: Text('No image Selected'),
                      )
                    : Image.file(
                        File(_image!.path),
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _getImage();
                },
                child: Text('Select Image'),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 390,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: DropdownButtonFormField<String>(
                    value: _serviceController.text.isNotEmpty
                        ? _serviceController.text
                        : null,
                    items: const [
                      DropdownMenuItem(
                        value: 'PAINTING',
                        child: Text('PAINTING'),
                      ),
                      DropdownMenuItem(
                        value: 'WASHING',
                        child: Text('WASHING'),
                      ),
                      DropdownMenuItem(
                        value: 'PLUMBING',
                        child: Text('PLUMBING'),
                      ),
                      DropdownMenuItem(
                        value: 'A/C',
                        child: Text('A/C'),
                      ),
                      DropdownMenuItem(
                        value: 'CLEANING',
                        child: Text('CLEANING'),
                      ),
                      DropdownMenuItem(
                        value: 'ELECTRICIAN',
                        child: Text('ELECTRICIAN'),
                      ),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        _serviceController.text = value ?? '';
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select a service';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Select Service',
                      labelText: 'Service',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 390,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter Service category';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Enter service category',
                      labelText: 'Service Category',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    addService();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Add Category to home'),
                        duration: Duration(seconds: 2),
                      ),
                    );

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNav1()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(300, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addService() {
    final serviceBox = Hive.box<ServiceModel2>('service2');
    final String addedCategoryName = _nameController.text.trim();

    serviceBox.add(ServiceModel2(
      _nameController.text,
      _image!.path,
      _serviceController.text,
    ));

    // Check if the added category name matches any heading in ServiceModel1
    final List<ServiceModel2> matchingServiceModel2List = serviceBox.values
        .where((serviceModel2) =>
            serviceModel2.category.trim() == addedCategoryName)
        .toList();

    if (matchingServiceModel2List.isNotEmpty) {
      for (var matchingServiceModel2 in matchingServiceModel2List) {
        // ignore: avoid_print
        print('Match found: ${matchingServiceModel2.category}');
        // ignore: avoid_print
        print('Image Path: ${matchingServiceModel2.imagePath}');

        // Create a new instance of ServiceModel1 using data from ServiceModel2
        final ServiceModel1 matchingServiceModel1 = ServiceModel1(
          matchingServiceModel2.category,
          matchingServiceModel2.imagePath,
          'description', // You may need to provide a default description or fetch it from somewhere
        );

        // Check if the added category matches the heading before navigating
        if (matchingServiceModel1.heading.trim() == addedCategoryName) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AcService(
                description: '',
                heading: 'head',
                serviceModel1: matchingServiceModel1,
                imagePath: 'path_to_image',
              ),
            ),
          );
          return;
        } else {
          // ignore: avoid_print
          print('No matching category found');
          // ignore: avoid_print
          print('Added category name: $addedCategoryName');
        }
      }
    }
  }
}

class SharedImage {
  static String? selectedImagePath;
}
