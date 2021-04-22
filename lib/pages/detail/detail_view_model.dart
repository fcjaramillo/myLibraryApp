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
      favoriteBook: false
    );
  }

  void onInit(BookModel book, bool favoriteBook) async {
    status = status.copyWith(book: book, favoriteBook: favoriteBook, isLoading: false);
  }

  void onTapFavorite(){
    status = status.copyWith(favoriteBook: !status.favoriteBook);
    addEffect(DetailSuccessSnackbar('''No se agrego a favoritos, 
    estamos trabajando en ello.''', 4));
  }

}