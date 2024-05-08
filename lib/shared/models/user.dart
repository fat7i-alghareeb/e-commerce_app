import 'package:hive_flutter/hive_flutter.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String gmail;
  @HiveField(2)
  final String password;
  @HiveField(3)
  bool lightThem;

  User({
    required this.userName,
    required this.gmail,
    required this.password,
    required this.lightThem,
  });
}
