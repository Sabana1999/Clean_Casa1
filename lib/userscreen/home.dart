import 'dart:io';

import 'package:casa_example/adminscreen.dart/addservice/add_details.dart';
import 'package:casa_example/adminscreen.dart/addservice/dba.dart';
import 'package:casa_example/adminscreen.dart/addcategory/item.dart';
import 'package:casa_example/color.dart';
import 'package:casa_example/userscreen/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../adminscreen.dart/additem/db2.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final String? selectedImagePath = SharedImage.selectedImagePath;
    if (selectedImagePath != null) {
      return Image.file(
        File(selectedImagePath),
        fit: BoxFit.cover,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  static void deleteItem(int index) {}
}

class _MyHomePageState extends State<MyHomePage> {
  late Box<ServiceModel> serviceBox;
  late Box<ServiceModel1> serviceBox1;

  @override
  void initState() {
    serviceBox = Hive.box<ServiceModel>('service');
    serviceBox1 = Hive.box<ServiceModel1>('service1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: serviceBox.listenable(),
        builder: (context, Box<ServiceModel> box, _) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 30),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Clean Casa',
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(color: Colors.white),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartPage()));
                              },
                              icon: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      subtitle: Text(
                        ''' Find your Custodian!''',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54),
                      ),
                    ),
                    const SizedBox(height: 30)
                  ],
                ),
              ),
              Container(
                color: primary,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(200)),
                  ),
                  child: GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 30,
                    children: List.generate(serviceBox.length, (index) {
                      // ignore: non_constant_identifier_names
                      final Service = serviceBox.getAt(index);
                      return GestureDetector(
                        onTap: () async {
                          String selectedName = Service.name;//!

                          // Find a matching ServiceModel1 based on the selectedName
                          ServiceModel1? correspondingServiceModel1;
                          try {
                            correspondingServiceModel1 =
                                serviceBox1.values.firstWhere(
                              (serviceModel1) =>
                                  serviceModel1.heading == selectedName,
                            );
                          // ignore: empty_catches
                          } catch (e) {}

                          if (correspondingServiceModel1 != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AcService(
                                  serviceModel1: correspondingServiceModel1 ??
                                      ServiceModel1('', '', ''),
                                  imagePath:
                                      correspondingServiceModel1?.imagePath ??
                                          '',
                                  heading:
                                      correspondingServiceModel1?.heading ?? '',
                                  description:
                                      correspondingServiceModel1?.description ??
                                          '',
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'No corresponding data found for $selectedName'),
                              ),
                            );
                          }
                        },
                        child: itemDashboard(Service!.name, Service.imagePath),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20)
            ],
          );
        },
      ),
    );
  }

  itemDashboard(String title, String imagePath) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: Theme.of(context).primaryColor.withOpacity(.2),
              spreadRadius: 2,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      );
  // ignore: unused_element
  static void deleteItem(int index) {}
}
