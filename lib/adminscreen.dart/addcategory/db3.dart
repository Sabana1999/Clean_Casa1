// service_model.dart

import 'package:hive/hive.dart';
part 'db3.g.dart';

@HiveType(typeId: 5)
class ServiceModel2 {
  @HiveField(0)
  final String service;
  @HiveField(1)
  final String imagePath;
  @HiveField(3)
  final String category;

  ServiceModel2(this.service, this.imagePath, this.category);
}
