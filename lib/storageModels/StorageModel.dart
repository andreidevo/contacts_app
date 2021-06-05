import 'package:hive/hive.dart';
part 'StorageModel.g.dart';


@HiveType(typeId: 0)
class StorageModel extends HiveObject{
  @HiveField(0)
  final String data;
  @HiveField(1)
  final String time;
  @HiveField(2)
  final String countContacts;
  @HiveField(3)
  final String fileMemory;
  @HiveField(4)
  final String pathFileVcf;


  StorageModel({this.data, this.time, this.countContacts, this.fileMemory, this.pathFileVcf});
}