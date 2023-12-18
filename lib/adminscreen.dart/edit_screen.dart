import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditScreen extends StatefulWidget {
  final String heading;
  final String description;
  final String imagePath;
  // ignore: use_key_in_widget_constructors
  const EditScreen({
    required this.heading,
    required this.description,
    required this.imagePath,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ImageSelectScreenState createState() => _ImageSelectScreenState();
}

class _ImageSelectScreenState extends State<EditScreen> {
  File? _imageFile;
  final TextEditingController _headingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    _headingController.text = widget.heading;
    _descriptionController.text = widget.description;
    _imageFile = File(widget.imagePath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Selection'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImageFromGallery();
                },
                child: Container(
                  height: 200, // Set your desired height for the image space
                  color: Colors.grey[300], // Placeholder color for image space
                  child: _imageFile == null
                      ? Center(
                          child: Text(
                            'Tap to Select Image',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Image.file(
                          _imageFile!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                
                controller: _headingController,
                decoration: InputDecoration(
                  labelText: 'Heading',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _saveData();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _saveData() {
    String heading = _headingController.text;
    String description = _descriptionController.text;

    Navigator.pop(context, {
      'heading': heading,
      'description': description,
      'imageFile': _imageFile,
    });
  }

  @override
  void dispose() {
    _headingController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
