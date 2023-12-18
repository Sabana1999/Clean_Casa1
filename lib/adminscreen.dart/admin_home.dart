import 'package:casa_example/adminscreen.dart/addcategory/addcategory.dart';
import 'package:casa_example/adminscreen.dart/adddeatils.dart/add.dart';
import 'package:casa_example/adminscreen.dart/additem/additem.dart';
import 'package:casa_example/adminscreen.dart/addservice/add_details.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/bullet_add.dart';
import 'package:casa_example/userscreen/drawer.dart';
import 'package:flutter/material.dart';

class AdHome extends StatefulWidget {
  const AdHome({super.key});

  @override
  State<AdHome> createState() => _AdHomeState();
}

class _AdHomeState extends State<AdHome> {
  final myitem = [
    Image.asset('asset/image/Scandinavian Green Kitchen.jpeg'),
    Image.asset('asset/image/Dark Green Guest Room with Boho Style _ The DIY Playbook.jpeg'),
    Image.asset('asset/image/What Color Carpet Goes with Green Walls_ - Homenish.jpeg'),
  ];
  // ignore: non_constant_identifier_names
  int MyCurrentIndex = 0;

  final gridItemImages = [
    'asset/image/firstt.jpg',
    'asset/image/download (4).jpg',
    'asset/image/ghg.jpg',
    'asset/image/download (7).jpeg',
    'asset/image/green app icon - reminders.jpeg'
  ];

  final gridItemTexts = [
    'Add Services',
    'Add Item',
    'Add Category',
    'Add Price',
    'Add Details'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home',
        ),
        elevation: 3,
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                '''    ''',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 700,
              padding: EdgeInsets.all(20),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.9,
                ),
                itemCount: gridItemImages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (index == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCategory()),
                        );
                      } else if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddItem()),
                        );

                      } else if (index == 2) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddHorizontal()),
                        );
                      }else if (index == 3) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BulletPointpage()),
                        );
                      }else if (index == 4) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddPoints()),
                        );
                      }
                    },
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                gridItemImages[index],
                                width: double.infinity,
                                height: 150, 
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.black.withOpacity(0.5),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Text(
                              gridItemTexts[index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

