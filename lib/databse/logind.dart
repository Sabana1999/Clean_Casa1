import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'logind.g.dart';

@HiveType(typeId: 1)
class User {
  @HiveField(0)
  final String? email;
  @HiveField(1)
  final String? password;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? number;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.number,
  });
}
