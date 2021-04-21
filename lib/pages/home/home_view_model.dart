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
      isLoading: true,
      titleBar: 'Libros Buscados',
      books: BuiltList<BookModel>(),
      numberList: 0,
      favoriteBooks: BuiltList<bool>(),
    );
  }

  void onInit() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      ResponseBookModel response = await _interactor.getBooks('cien+años+de+soledad');
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
      status = status.copyWith(books: response.docs, isLoading: false, numberList: response.docs.length, favoriteBooks: favoriteBooks);
    } else {
      addEffect(HomeErrorSnackbar(LibConstans.WithOutInternet, 4));
    }
  }

  void onTapBook(BookModel book) async {
    await _route.goDetail(book);
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
    books = await _database.getBooksFavorite();
    print(books.length);
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

  void onSearch(String? value) async {
    status = status.copyWith(isLoading: true);
    _route.pop(null);
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      ResponseBookModel response = await _interactor.getBooks(value!.replaceAll(RegExp(r' '), '+'));
      status = status.copyWith(books: response.docs, isLoading: false, numberList: response.docs.length);
    } else {
      addEffect(HomeErrorSnackbar(LibConstans.WithOutInternet, 4));
    }
    status = status.copyWith(isLoading: false);
  }

  void onTapDrawer(String page) async {
    _route.pop(null);
    switch(page) {
      case "search": {
        _route.goHome();
      }
      break;

      case "favorite": {
        print("Excellent");
      }
      break;

      default: {
        print("Invalid choice");
      }
      break;
    }
  }


}