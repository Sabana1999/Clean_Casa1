import 'package:casa_example/adminscreen.dart/addcategory/db3.dart';
import 'package:casa_example/adminscreen.dart/adddeatils.dart/db5.dart';
import 'package:casa_example/adminscreen.dart/additem/db2.dart';
import 'package:casa_example/adminscreen.dart/addservice/dba.dart';
import 'package:casa_example/adminscreen.dart/bullet.dart/itemscreen/db4.dart';
import 'package:casa_example/color.dart';
import 'package:casa_example/databse/logind.dart';
import 'package:casa_example/userscreen/address/addb.dart';
import 'package:casa_example/userscreen/cart/cardb.dart';
import 'package:casa_example/userscreen/splash.dart';
import 'package:casa_example/userscreen/userbookin/uerbkdb.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:firebase_core/firebase_core.dart';

// ignore: constant_identifier_names
const SAVEKEY = 'UserLoggedIn';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

//  if(!Hive.isAdapterRegistered(UserAdapter().typeId))

  Hive.registerAdapter(UserAdapter());

  Hive.registerAdapter(ServiceModelAdapter());
  await Hive.openBox<ServiceModel>('service');

  Hive.registerAdapter(ServiceModel1Adapter());
  await Hive.openBox<ServiceModel1>('service1');

  Hive.registerAdapter(ServiceModel2Adapter());
  await Hive.openBox<ServiceModel2>('service2');

  Hive.registerAdapter(ServiceModel3Adapter());
  await Hive.openBox<ServiceModel3>('service3');

  Hive.registerAdapter(ServiceModel4Adapter());
  await Hive.openBox<ServiceModel4>('service4');

  Hive.registerAdapter(CartAdapter());

  Hive.registerAdapter(AddressAdapter());
  await Hive.openBox<Address>('addressBox');

  Hive.registerAdapter(BookingAdapter());
  await Hive.openBox<Booking>('bookingBox');

  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDMExY7X-zvIL0UyokTDCKrP344-ltc878",
          appId: "1:36214107568:web:25c5f43d9debfd9f39ba75",
          messagingSenderId: "36214107568",
          projectId: "clean-casa",
          storageBucket: "clean-casa.appspot.com "));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: darkTheme,
      theme: ThemeData(
        primarySwatch: primary,
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("Error");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return ScreenSplash();
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
