import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 5)
class User {
  @HiveField(0)
  int coins;
  @HiveField(1)
  int background;
  @HiveField(2)
  int bulb;

  User({required this.coins, required this.background, required this.bulb});
}