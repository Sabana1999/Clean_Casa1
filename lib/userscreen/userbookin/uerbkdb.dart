import 'package:hive/hive.dart';
part 'uerbkdb.g.dart';

@HiveType(typeId: 11)
class Booking {
  
  @HiveField(1)
  final String? imagePath;
  @HiveField(2)
  final String? title;
  

  Booking( this.imagePath, this.title);
}
