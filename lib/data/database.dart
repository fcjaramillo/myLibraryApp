import 'package:built_collection/built_collection.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mylibrary/data/model/book_db.dart';

class Database {
  
  Future initDb() async {
    Hive.registerAdapter(BookDbAdapter());
    await Hive.initFlutter();
  }

  close() => Hive.close();

  //BOOKS
  Future setBookFavorite(BookDb book) async {
    final box = await Hive.openBox('book');
    await box.add(book);
  }

  Future<List<BookDb>> getBooksFavorite2() async {
    final box = await Hive.openBox('book');
    late BookDb bookDb;
    List<BookDb> lbooks = [];
    for (int i = 0; i < box.length; i++) {
      bookDb = box.getAt(i);
      lbooks.add(bookDb);
    }
    return lbooks;
  }

  Future<BuiltList<BookDb>> getBooksFavorite() async {
    final box = await Hive.openBox('book');
    late BookDb bookDb;
    BuiltList<BookDb> lbooks = BuiltList();
    for (int i = 0; i < box.length; i++) {
      bookDb = box.getAt(i);
      lbooks = lbooks.rebuild((b) => b
        ..add(bookDb));
    }
    return lbooks;
  }

  Future deleteBooksFavorite(int index) async {
    final box = await Hive.openBox('book');
    await box.deleteAt(index);
  }

}