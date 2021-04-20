import 'package:get_it/get_it.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';

GetIt locator = GetIt.instance;

void setUpLocator() async {

  locator.registerSingleton<LibRoute>(LibRoute());

  locator.registerSingletonAsync(() async {
    final database = Database();
    await database.initDb();
    return database;
  });

}