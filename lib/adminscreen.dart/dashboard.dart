import 'package:casa_example/userscreen/address/addb.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Box<Address> addressBox;
  late double totalPrices;
  late double monthlyLoss;

  @override
  void initState() {
    super.initState();
    addressBox = Hive.box<Address>('addressBox');
    totalPrices = calculateTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                'Income',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Rs. ${totalPrices.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 32, color: Color.fromARGB(255, 47, 118, 33)),
                    ),
                    SizedBox(height: 8),
                    Divider(
                      color: Colors.grey[400],
                      thickness: 2,
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Last Updated:',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text(
                          '${DateTime.now().toString().substring(0, 16)}',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Expanded(
            //  // child: Placeholder(), // Replace with your additional design or widgets
            // ),
          ],
        ),
      ),
    );
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var i = 0; i < addressBox.length; i++) {
      Address address = addressBox.getAt(i)!;
      if (address.price != null && address.price!.isNotEmpty) {
        total += double.parse(address.price!);
      }
    }
    return total;
  }
}
