

import 'package:mylibrary/viewModel.dart';

abstract class HomeEffect extends Effect{

}

class HomeDialogSearchEffect extends HomeEffect {
  HomeDialogSearchEffect();
}

class HomeFormValidate extends HomeEffect {
  HomeFormValidate();
}

class HomeErrorSnackbar extends HomeEffect {
  final String message;
  final int duration;

  HomeErrorSnackbar(this.message, this.duration);
}

class HomeSuccessSnackbar extends HomeEffect {
  final String message;
  final int duration;

  HomeSuccessSnackbar(this.message, this.duration);
}