// service_model.dart

import 'package:hive/hive.dart';
part 'cardb.g.dart';

@HiveType(typeId: 9)
class Cart {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? bulletPoint;
  @HiveField(3)
  final String? price;
  @HiveField(4)
  final String? imagePath;
  Cart(this.title, this.bulletPoint, this.price, this.imagePath);
}
