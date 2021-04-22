

import 'package:mylibrary/viewModel.dart';

abstract class FavoriteEffect extends Effect{

}

class FavoriteErrorSnackbar extends FavoriteEffect {
  final String message;
  final int duration;

  FavoriteErrorSnackbar(this.message, this.duration);
}

class FavoriteSuccessSnackbar extends FavoriteEffect {
  final String message;
  final int duration;

  FavoriteSuccessSnackbar(this.message, this.duration);
}