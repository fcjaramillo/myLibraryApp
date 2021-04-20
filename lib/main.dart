import 'package:flutter/material.dart';
import 'package:mylibrary/app_theme.dart';
import 'package:mylibrary/configure/get_it_locator.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';

void main() async {

  setUpLocator();
  await locator.allReady();

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void dispose() {
    locator<Database>().close();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: LibRoute().navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Library App',
      theme: AppTheme.build(),
      onGenerateRoute: locator<LibRoute>().generateRoute,
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}