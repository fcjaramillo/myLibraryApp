import 'package:built_collection/built_collection.dart';
import 'package:connectivity/connectivity.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/api/model/response_book_model.dart';
import 'package:mylibrary/api/repository/interactor/book_interactor.dart';
import 'package:mylibrary/commons/lib_constans.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';
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
    );
  }

  void onInit() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      ResponseBookModel response = await _interactor.getBooks('cien+años');
      status = status.copyWith(books: response.docs, isLoading: false, numberList: response.docs.length);
    } else {
      addEffect(HomeErrorSnackbar(LibConstans.WithOutInternet, 4));
    }
  }

  void onTapBook(BookModel book) async {
    await _route.goDetail(book);
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