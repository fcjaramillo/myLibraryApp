import 'package:built_collection/built_collection.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/viewModel.dart';

class HomeStatus extends ViewStatus {

  final String titleBar;
  final bool isLoading;
  final BuiltList<BookModel> books;
  final int numberList;
  final int numberMaxList;
  final BuiltList<bool> favoriteBooks;
  final String search;
  final int page;

  HomeStatus({
    required this.titleBar,
    required this.isLoading,
    required this.books,
    required this.numberList,
    required this.numberMaxList,
    required this.favoriteBooks,
    required this.search,
    required this.page,
  });

  HomeStatus copyWith({
    String? titleBar,
    bool? isLoading,
    BuiltList<BookModel>? books,
    int? numberList,
    int? numberMaxList,
    BuiltList<bool>? favoriteBooks,
    String? search,
    int? page,
  }){
    return HomeStatus(
      titleBar : titleBar ?? this.titleBar,
      isLoading : isLoading ?? this.isLoading,
      books: books ?? this.books,
      numberList: numberList ?? this.numberList,
      numberMaxList: numberMaxList ?? this.numberMaxList,
      favoriteBooks: favoriteBooks ?? this.favoriteBooks,
      search: search ?? this.search,
      page: page ?? this.page
    );
  }

}