import 'package:casa_example/adminscreen.dart/adddeatils.dart/db5.dart';
import 'package:casa_example/adminscreen.dart/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddPoints extends StatefulWidget {
  const AddPoints({Key? key}) : super(key: key);

  @override
  State<AddPoints> createState() => _AddPointsState();
}

class _AddPointsState extends State<AddPoints> {
  final _form = GlobalKey<FormState>();
  final _details1Controller = TextEditingController();
  final _details2Controller = TextEditingController();
  final _serviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _serviceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter service name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter service name',
                    labelText: 'service name',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _details1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter details1';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter details1',
                    labelText: 'details1',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _details2Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter details2';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter details2',
                    labelText: 'details2',
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    final details1 = _details1Controller.text;
                    final details2 = _details2Controller.text;
                    final service = _serviceController.text;
                    // ignore: non_constant_identifier_names
                    final ServiceModel =
                        ServiceModel4(details1, details2, service);
                    final servce4Box = Hive.box<ServiceModel4>('service4');
                    servce4Box.add(ServiceModel);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Service details added successfully'),
                      duration: Duration(seconds: 2),backgroundColor: Colors.greenAccent,
                    ));
                     Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BottomNav1()));
                  }
                 
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
