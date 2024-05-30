
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
class Stat extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int petitValue;
  @HiveField(3)
  int moyenValue;
  @HiveField(4)
  int grandValue;
  @HiveField(5)
  int globalValue;
  @HiveField(6)
  StatType type;

  Stat({ required this.name, required this.petitValue, required this.moyenValue, required this.grandValue, required this.globalValue, required this.type, required this.id});
}