import 'dart:io';

import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/addservice/dba.dart';
import 'package:casa_example/adminscreen.dart/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  XFile? _image;
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  Future<void> _getImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
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
        title: Text('Add Service'),
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
                    value: _nameController.text.isNotEmpty
                        ? _nameController.text
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
                        _nameController.text = value ?? '';
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
              SizedBox(height: 10),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    addService();

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
    final serviceBox = Hive.box<ServiceModel>('service');
    final serviceBox1 = Hive.box<ServiceModel1>('service1');

    final String categoryName = _nameController.text;
    final String imagePath = _image!.path;

    //  category already exists in ServiceModel1
    bool categoryExists = serviceBox1.values.any((serviceModel1) =>
        serviceModel1.heading.toUpperCase() == categoryName.toUpperCase());

    if (categoryExists) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Category already exists'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Category doesn't exist, add it to ServiceModel1
      serviceBox.add(ServiceModel(categoryName, imagePath));
      SharedImage.selectedImagePath = imagePath;

      // Show success message and navigate to the desired screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green,
          content: Text('Add services to home'),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => BottomNav1()),
      );
    }
  }
}

class SharedImage {
  static String? selectedImagePath;
}
