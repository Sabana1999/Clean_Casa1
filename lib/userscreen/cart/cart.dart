import 'dart:io';

import 'package:casa_example/userscreen/address/address.dart';
import 'package:casa_example/userscreen/cart/cardb.dart';
import 'package:casa_example/userscreen/cart/inside_cart.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Box<Cart>? cartBox;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    openBox();
    cartBox = Hive.box<Cart>('cart');
  }

  Future<void> openBox() async {
    cartBox = await Hive.openBox<Cart>('cart');
    updateTotalPrice();
    setState(() {});
  }

  // calculate total price
  void updateTotalPrice() {
    double total = 0.0;

    if (cartBox != null) {
      for (int i = 0; i < cartBox!.length; i++) {
        // ignore: unnecessary_cast
        final cartItem = cartBox!.getAt(i) as Cart?;

        if (cartItem != null && cartItem.price != null) {
          double price = double.tryParse(cartItem.price ?? '0.0') ?? 0.0;
          total += price;
        }
      }
    }

    setState(() {
      totalPrice = total;
    });
  }

  //  delet cart
  void deleteCartItem(int index) {
    cartBox!.deleteAt(index);
    updateTotalPrice(); 
  }

//additem
  void addItemToCart(Cart newItem) {
    cartBox!.add(newItem);
    updateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              onPressed: () {
                if (cartBox != null && cartBox!.isNotEmpty) {
                        List<Cart> cartItems = cartBox!.values.toList();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddressPage(
                        cartItems:cartItems
                       
                      ),
                    ),
                  );
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Cart is empty'),backgroundColor: Colors.redAccent,),
                );

                }

               
              },
              icon: Icon(Icons.arrow_forward_ios_outlined)
              )
        ],
        title: Text('Cart Page'),
      ),
      body: cartBox == null 
      // ||cartBox!.isOpen
          ? Center(
              child: CircularProgressIndicator(),
            )
          : cartBox!.isEmpty
              ? Center(
                  child: Image.asset('asset/image/cart.png',width: 300,),
                )
              : ListView.builder(
                  itemCount: cartBox!.length,
                  itemBuilder: (BuildContext context, int index) {
                    // ignore: unnecessary_cast
                    final cartItem = cartBox!.getAt(index) as Cart?;

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InsideCart(
                                      imagePath: cartItem?.imagePath,
                                      title: cartItem?.title,
                                      price: cartItem?.price,
                                      bulletDetail: cartItem?.bulletPoint ?? '',
                                    )));
                      },
                      leading: cartItem?.imagePath != null
                          ? Image.file(File(cartItem!.imagePath!))
                          : SizedBox(),
                      title: Text(cartItem?.title ?? ''),
                      subtitle: Text('Price: ${cartItem?.price ?? ''}'),
                      trailing: IconButton(
                        onPressed: () {
                          deleteCartItem(index);
                        },
                        icon: Icon(Icons.delete),
                      ),
                    );
                  },
                ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total Price: Rs.${totalPrice.toStringAsFixed(2)}',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
