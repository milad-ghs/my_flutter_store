import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String phoneNumber;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? profileImagePath;
  
  User({required this.phoneNumber, this.name , this.profileImagePath});
}
