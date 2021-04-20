import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/pages/detail/detail_effect.dart';
import 'package:mylibrary/pages/detail/detail_status.dart';
import 'package:mylibrary/viewModel.dart';

class DetailViewModel extends EffectsViewModel<DetailStatus, DetailEffect>{

  final LibRoute _route;

  DetailViewModel(this._route){
    status = DetailStatus(
      isLoading: true,
      titleBar: 'Detalle',
      book: BookModel(
         (b) => b
        ..title = ''
        ..key = ''
      ),
    );
  }

  void onInit(BookModel book) async {
    status = status.copyWith(book: book, isLoading: false);
  }

}