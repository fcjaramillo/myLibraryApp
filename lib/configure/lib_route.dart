import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/pages/home/home_page.dart';

class LibRoute {

  static final LibRoute _singleton = LibRoute._internal();

  factory LibRoute() {
    return _singleton;
  }

  LibRoute._internal();

  final navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  void pop<T>(T result){
    navigatorKey.currentState!.pop<T>(result);
  }

  goHome(){
    return navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(builder: (_)=> HomePage())
    );
  }

}
