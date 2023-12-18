import 'package:flutter/material.dart';

class EditCatg extends StatefulWidget {
  final String details1;
  final String details2;
  final String price;

  const EditCatg({
    Key? key,
    required this.details1,
    required this.details2,
    required this.price,
  }) : super(key: key);

  @override
  State<EditCatg> createState() => _EditCatgState();
}

class _EditCatgState extends State<EditCatg> {
  late TextEditingController _details1Controller;
  late TextEditingController _details2Controller;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _details1Controller = TextEditingController(text: widget.details1    );
    _details2Controller = TextEditingController(text: widget.details2);
    _priceController = TextEditingController(text: widget.price);

    
  }
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            TextFormField(
              controller: _details1Controller,
              decoration: InputDecoration(
                labelText: 'Details 1',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _details2Controller,
              decoration: InputDecoration(
                labelText: 'Details 2',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.blue, width: 2.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context,{
                  'detail1':_details1Controller.text,
                   'detail2':_details2Controller.text,
                   'price':_priceController.text,

                  
                });
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _details1Controller.dispose();
    _details2Controller.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
