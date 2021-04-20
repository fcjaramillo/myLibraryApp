import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Database {
  
  Future initDb() async {
    await Hive.initFlutter();
  }

  close() => Hive.close();

}