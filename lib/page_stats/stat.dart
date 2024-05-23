
import 'package:hive_flutter/hive_flutter.dart';
part 'stat.g.dart';

@HiveType(typeId: 3)
enum StatType {
  @HiveField(0)
  numeric,

  @HiveField(1)
  time

}

@HiveType(typeId: 1)
class Stat {
  @HiveField(0)
  String name;
  @HiveField(1)
  int petitValue;
  @HiveField(2)
  int moyenValue;
  @HiveField(3)
  int grandValue;
  @HiveField(4)
  int globalValue;
  @HiveField(5)
  StatType type;

  Stat({ required this.name, required this.petitValue, required this.moyenValue, required this.grandValue, required this.globalValue, required this.type});
}