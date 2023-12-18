
import 'package:hive/hive.dart';
part 'addb.g.dart';

@HiveType(typeId: 10)
class Address {
  @HiveField(0)
  final String? date ;
  @HiveField(1)
  final String? time;
  @HiveField(3)
  final String? address;
  @HiveField(4)
  final String? phoneno;
  @HiveField(5)
  final String? imagePath;
  @HiveField(6)
  final String? title;
  @HiveField(7)
  final String? price;

  Address(this.date, this.time, this.address, this.phoneno, this.imagePath, this.title, this.price);

}

