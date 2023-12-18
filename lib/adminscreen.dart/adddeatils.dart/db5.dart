// service_model.dart

import 'package:hive/hive.dart';
part 'db5.g.dart';

@HiveType(typeId: 7)
class ServiceModel4 {
  @HiveField(0)
 String details1;
  
  
  @HiveField(1)
  String details2;

  @HiveField(2)
  late final String service;
  

  ServiceModel4( this.details1, this.details2, this.service);

  get key => '';

  
}
