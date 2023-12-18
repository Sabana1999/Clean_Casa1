// service_model.dart

import 'package:hive/hive.dart';
part 'db4.g.dart';

@HiveType(typeId: 6)
class ServiceModel3 {
  @HiveField(0)
  final String title;
  
  
  @HiveField(3)
  String price;

  ServiceModel3(this.title, this.price, );

  get key => null;
}
