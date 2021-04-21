import 'package:built_collection/built_collection.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/viewModel.dart';

class HomeStatus extends ViewStatus {

  final String titleBar;
  final bool isLoading;
  final BuiltList<BookModel> books;
  final int numberList;
  final BuiltList<bool> favoriteBooks;

  HomeStatus({required this.titleBar, required this.isLoading, required this.books, required this.numberList, required this.favoriteBooks});

  HomeStatus copyWith({String? titleBar, bool? isLoading, BuiltList<BookModel>? books, int? numberList, BuiltList<bool>? favoriteBooks}){
    return HomeStatus(
      titleBar : titleBar ?? this.titleBar,
      isLoading : isLoading ?? this.isLoading,
      books: books ?? this.books,
      numberList: numberList ?? this.numberList,
      favoriteBooks: favoriteBooks ?? this.favoriteBooks,
    );
  }

}