import 'package:built_collection/built_collection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/api/model/response_book_model.dart';
import 'package:mylibrary/api/repository/interactor/book_interactor.dart';
import 'package:mylibrary/commons/lib_constans.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';
import 'package:mylibrary/data/model/book_db.dart';
import 'package:mylibrary/pages/favorite/favorite_effect.dart';
import 'package:mylibrary/pages/favorite/favorite_status.dart';
import 'package:mylibrary/viewModel.dart';


class FavoriteViewModel extends EffectsViewModel<FavoriteStatus, FavoriteEffect>{

  final LibRoute _route;
  final Database _database;

  FavoriteViewModel(this._route, this._database){
    status = FavoriteStatus(
      isLoading: true,
      titleBar: 'Favoritos',
      books: BuiltList<BookModel>(),
      numberList: 0,
      favoriteBooks: BuiltList<bool>(),
    );
  }

  void onInit() async {
    BuiltList<BookDb> books =  await _database.getBooksFavorite();
    BuiltList<bool> favoriteBooks = BuiltList();
    BuiltList<BookModel> dataBooks = BuiltList();
    ListBuilder<String>? author = ListBuilder();
    books.forEach((book) {
      author = ListBuilder();
      book.authorName.forEach((a) {
        author!.add(a);
      });
      dataBooks = dataBooks.rebuild((b) => b
        ..add( BookModel((b) => b
          ..key = book.key
          ..authorName = author
          ..editionCount = book.editionCount
          ..firstPublishYear = book.firstPublishYear
          ..hasFulltext = book.hasFulltext
          ..title = book.title
        ))
      );
      favoriteBooks = favoriteBooks.rebuild((b) => b
        ..add(true));
    });
    status = status.copyWith(books: dataBooks, isLoading: false, numberList: dataBooks.length, favoriteBooks: favoriteBooks);
  }

  void onTapFavorite(BookModel book, int indexBook) async {
    await _database.deleteBooksFavorite(indexBook);
    status = status.copyWith(
      favoriteBooks: status.favoriteBooks.rebuild((b) => b
        ..removeAt(indexBook)
      ),
      books: status.books.rebuild((b) => b
        ..removeAt(indexBook)
      ),
      numberList: status.books.length-1
    );
  }

  void onTapBook(BookModel book, bool favoriteBook) async {
    await _route.goDetail(book, favoriteBook);
  }

}