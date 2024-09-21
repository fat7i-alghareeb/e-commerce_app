import 'package:hive_flutter/hive_flutter.dart';
part "user_entity.g.dart";

@HiveType(typeId: 1)
class UserEntity extends HiveObject {
  @HiveField(0)
  final String userName;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final String uId;
  @HiveField(3)
  bool isDarkTheme;
  UserEntity({
    required this.isDarkTheme,
    required this.userName,
    required this.email,
    required this.uId,
  });
}
