import 'dart:io';

import 'package:casa_example/color.dart';
import 'package:casa_example/userscreen/address/addb.dart';
import 'package:casa_example/userscreen/cart/cardb.dart';
import 'package:casa_example/userscreen/success.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddressPage extends StatefulWidget {
  final List<Cart> cartItems;

  // ignore: use_key_in_widget_constructors
  const AddressPage({
    Key? key,
    required this.cartItems,
  });

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  // ignore: unused_field
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    //addressController.text = widget.title;
  }

  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
      // Format the selected date
      String formattedDate =
          "${selectedDate.year}/${_getMonthName(selectedDate.month)}/${selectedDate.day.toString().padLeft(2, '0')}";
      dateController.text = formattedDate;
    });
  }
}

String _getMonthName(int month) {
  switch (month) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
    default:
      return '';
  }
}


  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
        timeController.text = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Now'),
      ),
      body: SingleChildScrollView(
        child: Form(
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: const [
                    Text(
                      'Book Your Service',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = widget.cartItems[index];

                  return ListTile(
                    leading: cartItem.imagePath != null &&
                            cartItem.imagePath!.isNotEmpty
                        ? Image.file(
                            File(cartItem.imagePath ??
                                ''), 
                            width: 50,
                            height: 50,
                          )
                        : Icon(Icons
                            .image), 
                    title: Text(cartItem.title ??
                        'No title'), 
                    subtitle: Text(
                        'Price: ${cartItem.price ?? ''}'), 
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: dateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_today),
                    labelText: 'Date',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a date';
                    }
                    return null;
                  },
                  onSaved: (value) {
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: timeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    prefixIcon: const Icon(Icons.access_time),
                    labelText: 'Time',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  onTap: () {
                    _selectTime(context);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select a time';
                    }
                    return null;
                  },
                  onSaved: (value) {
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  maxLines: 3,
                  controller: addressController,
                  decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    prefixIcon: const Icon(Icons.location_on),
                    labelText: 'Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: phoneController,
                  keyboardType:
                      TextInputType.phone, 
                  decoration: InputDecoration(
                    fillColor: Colors.black12,
                    filled: true,
                    prefixIcon: const Icon(Icons.phone),
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) {},
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
  final addressBox = Hive.box<Address>('addressBox');

  for (var item in widget.cartItems) {
    Address newAddress = Address(
      dateController.text,
      timeController.text,
      addressController.text,
      phoneController.text,
      item.imagePath,
      item.title,
      item.price,
    );

    addressBox.add(newAddress);
  }

  // Remove cart items after adding to the address
  final cartBox = Hive.box<Cart>('cart');
  for (var item in widget.cartItems) {
    int index = cartBox.values.toList().indexWhere(
      (cart) =>
          cart.title == item.title && cart.imagePath == item.imagePath,
    );
    if (index != -1) {
      cartBox.deleteAt(index);
    }
  }

  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PaymentSuccessScreen(),
    ),
  );
},

                    style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        fixedSize: Size(400, 45),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Text('Book Now')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
