import 'package:built_collection/built_collection.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/viewModel.dart';

class HomeStatus extends ViewStatus {

  final String titleBar;
  final bool isLoading;
  final BuiltList<BookModel> books;
  final int numberList;

  HomeStatus({required this.titleBar, required this.isLoading, required this.books, required this.numberList});

  HomeStatus copyWith({String? titleBar, bool? isLoading, BuiltList<BookModel>? books, int? numberList}){
    return HomeStatus(
      titleBar : titleBar ?? this.titleBar,
      isLoading : isLoading ?? this.isLoading,
      books: books ?? this.books,
      numberList: numberList ?? this.numberList,
    );
  }

}