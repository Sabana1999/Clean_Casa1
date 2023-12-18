// service_model.dart

import 'package:hive/hive.dart';
part 'dba.g.dart';
@HiveType(typeId: 3)
class ServiceModel {

  
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String imagePath;

  ServiceModel(this.name,  this.imagePath);
}
