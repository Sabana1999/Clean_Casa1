import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/db4.dart';

class PriceEdit extends StatefulWidget {
  final String currentPrice;


  const PriceEdit(
      {Key? key, required this.currentPrice})
      : super(key: key);

  @override
  State<PriceEdit> createState() => _PriceEditState();
}

class _PriceEditState extends State<PriceEdit> {
  // ignore: prefer_final_fields
  TextEditingController _priceController =
      TextEditingController(); // Initializing the controller

  late Box<ServiceModel3> _serviceBox;
  late ServiceModel3 _serviceModel;

  @override
  void initState() {
    super.initState();
    _priceController.text = widget.currentPrice; // Assigning the initial value
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.openBox<ServiceModel3>('service3');
    _serviceBox = Hive.box<ServiceModel3>('service3');
    _serviceModel = _serviceBox.getAt(0)!;
    
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _updatePrice() {
    String updatedPrice = _priceController.text;
    _serviceModel.price = updatedPrice; // updated price
    _serviceBox.putAt(0, _serviceModel);
     Navigator.pop(context,updatedPrice);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Price Edit'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(30),
            child: TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _updatePrice();
             
               },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(300, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
