import 'package:mylibrary/viewModel.dart';

abstract class DetailEffect extends Effect{

}

class DetailErrorSnackbar extends DetailEffect {
  final String message;
  final int duration;

  DetailErrorSnackbar(this.message, this.duration);
}

class DetailSuccessSnackbar extends DetailEffect {
  final String message;
  final int duration;

  DetailSuccessSnackbar(this.message, this.duration);
}