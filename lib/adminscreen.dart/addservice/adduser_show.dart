import 'dart:io';

import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/additem/additem_show.dart';
import 'package:casa_example/adminscreen.dart/addservice/dba.dart';
import 'package:casa_example/color.dart';
import 'package:casa_example/userscreen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
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
                      title: Text(
                        'Clean Casa',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.white),
                      ),
                      subtitle: Text(
                        'Find your Custodian!',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.white54),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                          String selectedName = Service.name;

                          // Find a matching ServiceModel1 based on the selectedName
                          ServiceModel1? correspondingServiceModel1;
                          try {
                            correspondingServiceModel1 =
                                serviceBox1.values.firstWhere(
                              (serviceModel1) =>
                                  serviceModel1.heading == selectedName,
                            );
                          } catch (e) {
                            // Do nothing if no matching ServiceModel1 is found
                          }

                          if (correspondingServiceModel1 != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AcService1(
                                  serviceModel1: correspondingServiceModel1 ??
                                      ServiceModel1('', '', ''),
                                  imagePath:
                                      correspondingServiceModel1?.imagePath ?? '',
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
                        child:
                            itemDashboard(Service!.name, Service.imagePath, index),
                      );
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }

  itemDashboard(String title, String imagePath, int index) => Container(
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
        child: Stack(
          children: [
            Column(
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
                Text(title.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  // Add your logic to delete the item at the given index
                  _deleteItem(index);
                },
              ),
            ),
          ],
        ),
      );
  
  void _deleteItem(int index) {
    serviceBox.deleteAt(index);
    MyHomePage.deleteItem(index);
  }
}

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}
