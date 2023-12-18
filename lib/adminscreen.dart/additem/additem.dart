import 'dart:io';

import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddItem> {
  XFile? _image;
  final _form = GlobalKey<FormState>();
  //final _desController = TextEditingController();
  final _details1Controller = TextEditingController();
  final _sevicename = TextEditingController();
  final _desController = TextEditingController();

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
        title: Text('Add item'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                height: 7,
              ),
              ElevatedButton(
                onPressed: () {
                  _getImage();
                },
                child: Text('Select Image'),
              ),
              SizedBox(
                height: 7,
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: DropdownButtonFormField<String>(
                  value: _desController.text.isNotEmpty
                      ? _desController.text
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
                      _desController.text = value ?? '';
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
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  maxLines: 4,
                  controller: _details1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter Description',
                    labelText: 'Description',
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: _sevicename,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter Service name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter Service name',
                    labelText: 'Service name',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    addService();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Item added Successfully '),
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
    final serviceBox = Hive.box<ServiceModel1>('service1');
    serviceBox.add(
      ServiceModel1(
        _desController.text,
        _image!.path,
        _details1Controller.text,
      ),
    );
    SharedImage.selectedImagePath = _image!.path;
  }
}

class SharedImage {
  static String? selectedImagePath;
}
