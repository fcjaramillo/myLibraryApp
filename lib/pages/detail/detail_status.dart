import 'package:built_collection/built_collection.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/viewModel.dart';

class DetailStatus extends ViewStatus {

  final String titleBar;
  final bool isLoading;
  final BookModel book;

  DetailStatus({required this.titleBar, required this.isLoading, required this.book});

  DetailStatus copyWith({String? titleBar, bool? isLoading, BookModel? book}){
    return DetailStatus(
      titleBar : titleBar ?? this.titleBar,
      isLoading : isLoading ?? this.isLoading,
      book: book ?? this.book,
    );
  }

}