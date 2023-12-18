// service_model.dart

import 'package:hive/hive.dart';
part 'db2.g.dart';
@HiveType(typeId: 4)
class ServiceModel1 {
  @HiveField(0)
  final String heading ;
  @HiveField(1)
  final String imagePath;
  @HiveField(2)
  final String description;


  ServiceModel1(this.heading,  this.imagePath,this.description);

  get key => null;
}
