import 'package:built_collection/built_collection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/api/model/response_book_model.dart';
import 'package:mylibrary/api/repository/interactor/book_interactor.dart';
import 'package:mylibrary/commons/lib_constans.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';
import 'package:mylibrary/data/model/book_db.dart';
import 'package:mylibrary/pages/home/home_effect.dart';
import 'package:mylibrary/pages/home/home_status.dart';
import 'package:mylibrary/viewModel.dart';


class HomeViewModel extends EffectsViewModel<HomeStatus, HomeEffect>{

  final LibRoute _route;
  final Database _database;
  final BookInteractor _interactor;

  HomeViewModel(this._route, this._database, this._interactor){
    status = HomeStatus(
      isLoading: false,
      titleBar: 'Libros Buscados',
      books: BuiltList<BookModel>(),
      numberList: 0,
      numberMaxList: 0,
      favoriteBooks: BuiltList<bool>(),
      search: '',
      page: 1
    );
  }

  void onInit() async {
    /*final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      ResponseBookModel response = await _interactor.getBooks('cien+años+de+soledad', status.page.toString());
      BuiltList<BookDb> books =  await _database.getBooksFavorite();
      BuiltList<bool> favoriteBooks = BuiltList();
      bool favorite = false;
      response.docs.forEach((d) {
        favorite = false;
        books.asMap().forEach((i, b) {
          if(d.key == b.key){
            favorite = true;
            return;
          }
        });
        favoriteBooks = favoriteBooks.rebuild((b) => b
          ..add(favorite));
      });
      status = status.copyWith(books: response.docs, isLoading: false, numberList: response.docs.length, numberMaxList: response.numFound, favoriteBooks: favoriteBooks);
    } else {
      addEffect(HomeErrorSnackbar(LibConstans.WithOutInternet, 4));
    }*/
  }

  void onTapBook(BookModel book, bool favoriteBook) async {
    await _route.goDetail(book, favoriteBook);
  }

  void onTapFavorite(BookModel book, int indexBook) async {
    BuiltList<BookDb> books =  await _database.getBooksFavorite();
    int index = -1;
    books.asMap().forEach((i, b) {
      if(book.key == b.key){
        index = i;
        return;
      }
    });
    if(index < 0){
      await _database.setBookFavorite(
        BookDb(
          hasFulltext: book.hasFulltext!,
          editionCount: book.editionCount!,
          title: book.title!,
          authorName: book.authorName.toList(),
          firstPublishYear: book.firstPublishYear!,
          key: book.key!,
          ia: book.ia.toList(),
          authorKey: book.authorKey.toList()
        )
      );
      status = status.copyWith(
        favoriteBooks: status.favoriteBooks.rebuild((b) => b
          ..setAll(indexBook, [true])
        )
      );
    } else{
      await _database.deleteBooksFavorite(index);
      status = status.copyWith(
        favoriteBooks: status.favoriteBooks.rebuild((b) => b
          ..setAll(indexBook, [false])
        )
      );
    }
  }

  void onTapOpenDialog(){
    addEffect(HomeDialogSearchEffect());
  }

  void onTapCancelDialog(){
    _route.pop(null);
  }

  void onValidateForm(){
    addEffect(HomeFormValidate());
  }

  String? onValidateSearch(String? value){
    print(value);
    if (value == ''){
      return "Este campo es obligatorio.";
    }
    return null;
  }

  void onSearch(String value, bool backRoute) async {
    status = status.copyWith(isLoading: true);
    if(backRoute){
      _route.pop(null);
    }
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      ResponseBookModel response = await _interactor.getBooks(value.replaceAll(RegExp(r' '), '+'), status.page.toString());
      BuiltList<BookDb> books =  await _database.getBooksFavorite();
      BuiltList<bool> favoriteBooks = BuiltList();
      bool favorite = false;
      response.docs.forEach((d) {
        favorite = false;
        books.asMap().forEach((i, b) {
          if(d.key == b.key){
            favorite = true;
            return;
          }
        });
        favoriteBooks = favoriteBooks.rebuild((b) => b
          ..add(favorite));
      });
      status = status.copyWith(books: response.docs, isLoading: false, numberList: response.docs.length, numberMaxList: response.numFound, favoriteBooks: favoriteBooks, search: value, page: 1);
    } else {
      addEffect(HomeErrorSnackbar(LibConstans.WithOutInternet, 4));
    }
    status = status.copyWith(isLoading: false);
  }

  void moreRequest() async {
    print(status.numberMaxList);
    print(status.page * 100);
    if (status.numberMaxList > status.page * 100) {
      final connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        status = status.copyWith(isLoading: true);
        ResponseBookModel response = await _interactor.getBooks(status.search.replaceAll(RegExp(r' '), '+'), (status.page + 1).toString());
        BuiltList<BookDb> books =  await _database.getBooksFavorite();
        BuiltList<bool> favoriteBooks = status.favoriteBooks;
        BuiltList<BookModel> statusBooks = status.books;
        bool favorite = false;
        response.docs.forEach((d) {
          favorite = false;
          books.asMap().forEach((i, b) {
            if(d.key == b.key){
              favorite = true;
              return;
            }
          });
          favoriteBooks = favoriteBooks.rebuild((b) => b
            ..add(favorite));
          statusBooks = statusBooks.rebuild((b) => b
            ..add(d));
        });
        status = status.copyWith(books: statusBooks, isLoading: false, numberList: statusBooks.length, favoriteBooks: favoriteBooks, page: status.page + 1);
      } else {
        addEffect(HomeErrorSnackbar(LibConstans.WithOutInternet, 4));
      }
    } else {
      addEffect(HomeSuccessSnackbar(LibConstans.maxBooks, 4));
    }

  }

  void onTapDrawer(String page) async {
    _route.pop(null);
    switch(page) {
      case "search": {

      }
      break;

      case "favorite": {
        await _route.goFavorite();
        onSearch(status.search, false);
      }
      break;
    }
  }


}