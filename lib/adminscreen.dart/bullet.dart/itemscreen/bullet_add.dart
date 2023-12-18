import 'package:casa_example/adminscreen.dart/bottom_nav.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/db4.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BulletPointpage extends StatefulWidget {
  final String? price; // Price variable

  const BulletPointpage({super.key, this.price});

  @override
  State<BulletPointpage> createState() => _BulletPointState();
}

class _BulletPointState extends State<BulletPointpage> {
  final _form = GlobalKey<FormState>();
  //final _details1Controller = TextEditingController();
  // final _details2Controller = TextEditingController();
  final _headingController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Price '),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  controller: _headingController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter service';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter service',
                    labelText: 'service',
                  ),
                ),
              ),
              Container(
                
                padding: EdgeInsets.all(20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter price';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: 'Enter price',
                    labelText: 'price',
                    
                  ),
                ),
              ),
              //    Container(
              //      padding: EdgeInsets.all(20),
              //      child: TextFormField(
              //        controller: _details1Controller,
              //        validator: (value) {
              //          if (value == null || value.isEmpty) {
              //            return 'Enter details';
              //          }
              //          return null;
              //        },
              //        decoration: InputDecoration(
              //          border: OutlineInputBorder(
              //            borderRadius: BorderRadius.circular(20),
              //          ),
              //          hintText: 'Enter details',
              //          labelText: 'details',
              //        ),
              //      ),
              //    ),
              //    Container(
              //      padding: EdgeInsets.all(20),
              //      child: TextFormField(
              //        controller: _details2Controller,
              //        validator: (value) {
              //          if (value == null || value.isEmpty) {
              //            return 'Enter details';
              //          }
              //          return null;
              //        },
              //        decoration: InputDecoration(
              //          border: OutlineInputBorder(
              //            borderRadius: BorderRadius.circular(20),
              //          ),
              //          hintText: 'Enter details',
              //          labelText: 'details',
              //        ),
              //      ),
              //    ),
              ElevatedButton(
                onPressed: () {
                  if (_form.currentState!.validate()) {
                    String serviceTitle = _headingController.text;
                    //String details1 = _details1Controller.text??'';
                    //String details2 = _details2Controller.text??'';
                    String price = _priceController.text;
                    ServiceModel3 serviceModel =
                        ServiceModel3(serviceTitle, price);
                    final serviceBox = Hive.box<ServiceModel3>('service3');
                    serviceBox.put(serviceTitle, serviceModel);

                    ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor:Colors.green,
                      content: Text('Price addedd successful'),
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
}
