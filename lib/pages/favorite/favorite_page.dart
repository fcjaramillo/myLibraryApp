import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylibrary/commons/lib_colors.dart';
import 'package:mylibrary/configure/get_it_locator.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';
import 'package:mylibrary/pages/favorite/favorite_effect.dart';
import 'package:mylibrary/pages/favorite/favorite_view_model.dart';
import 'package:mylibrary/widgets/book_card.dart';
import 'package:mylibrary/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mylibrary/extensions/snackbar_extension.dart';
import 'package:mylibrary/app_theme.dart';

class FavoritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteViewModel(
        locator<LibRoute>(),
        locator<Database>(),
      ),
      builder: (context, _){
        return FavoriteWidget();
      },
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<FavoriteViewModel>();

    return Scaffold(
      backgroundColor: LibColors.white,
      appBar: AppBar(
        title: Text(
          viewModel.status.titleBar,
        ),
      ),
      body: _favoriteBody(),
    );
  }
}

class _favoriteBody extends StatefulWidget {
  @override
  __favoriteBodyState createState() => __favoriteBodyState();
}

class __favoriteBodyState extends State<_favoriteBody> {

  late StreamSubscription<FavoriteEffect> _effectSubscription;

  @override
  void initState(){
    final viewModel = context.read<FavoriteViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if(event is FavoriteSuccessSnackbar){
        context.showSuccessSnackbar(message: event.message, duration: event.duration);
      } else if(event is FavoriteErrorSnackbar){
        context.showErrorSnackbar(message: event.message, duration: event.duration);
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      viewModel.onInit();
    });

    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<FavoriteViewModel>();
    final textTheme = Theme.of(context).textTheme;

    var loading = viewModel.status.isLoading ? LibProgressIndicator() : SizedBox.shrink();
    return Stack(
      children: [
        Visibility(
          visible: viewModel.status.numberList > 0,
          child: ListView.builder(
            itemCount: viewModel.status.numberList,
            itemBuilder: (context, index) {
              return BookCard(
                book: viewModel.status.books[index],
                favoriteBook: viewModel.status.favoriteBooks[index],
                onTap: (){
                  viewModel.onTapBook(viewModel.status.books[index], viewModel.status.favoriteBooks[index]);
                },
                onTapFavorite: (){
                  viewModel.onTapFavorite(viewModel.status.books[index], index);
                },
              );
            },
          ),
          replacement: Center(
            child: Text(
              'No tienes registrado ningún libro o autor favorito.',
              style: textTheme.subtitleBlack,
            )
          ),
        ),
        loading
      ],
    );
  }

}