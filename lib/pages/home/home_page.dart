import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mylibrary/api/repository/interactor/book_interactor.dart';
import 'package:mylibrary/commons/lib_colors.dart';
import 'package:mylibrary/configure/get_it_locator.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/data/database.dart';
import 'package:mylibrary/pages/home/home_effect.dart';
import 'package:mylibrary/pages/home/home_view_model.dart';
import 'package:mylibrary/widgets/book_card.dart';
import 'package:mylibrary/widgets/drawer.dart';
import 'package:mylibrary/widgets/progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:mylibrary/extensions/snackbar_extension.dart';
import 'package:mylibrary/extensions/dialog_search_extension.dart';
import 'package:mylibrary/app_theme.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(
        locator<LibRoute>(),
        locator<Database>(),
        locator<BookInteractor>(),
      ),
      builder: (context, _){
        return HomeWidget();
      },
    );
  }
}

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {

  @override
  Widget build(BuildContext context) {

    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: LibColors.white,
      appBar: AppBar(
        title: Text(
          viewModel.status.titleBar,
        ),
      ),
      drawerScrimColor: LibColors.blueOpacity,
      drawer: AppDrawer(
        onTap: (String type) => viewModel.onTapDrawer(type),
        userName: 'Usuario',
      ),
      body: _homeBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.search
        ),
        onPressed: viewModel.onTapOpenDialog,
      ),
    );
  }
}

class _homeBody extends StatefulWidget {
  @override
  __homeBodyState createState() => __homeBodyState();
}

class __homeBodyState extends State<_homeBody> {

  final keyFormDialog = GlobalKey<FormState>();
  final searchCtrl = TextEditingController();

  ScrollController _scrollController = new ScrollController();
  late StreamSubscription<HomeEffect> _effectSubscription;

  @override
  void initState(){
    final viewModel = context.read<HomeViewModel>();

    _effectSubscription = viewModel.effects.listen((event) {
      if(event is HomeDialogSearchEffect){
        context.showDialogSearch(
          keyForm: keyFormDialog,
          searchCtl: searchCtrl,
          searchValidator: viewModel.onValidateSearch,
          onTapCancel: viewModel.onTapCancelDialog,
          onTapAccept: viewModel.onValidateForm,
        );
      } else if(event is HomeFormValidate) {
        if(keyFormDialog.currentState!.validate()){
          viewModel.onSearch(searchCtrl.text, true);
        }
      } else if(event is HomeSuccessSnackbar){
        context.showSuccessSnackbar(message: event.message, duration: event.duration);
      } else if(event is HomeErrorSnackbar){
        context.showErrorSnackbar(message: event.message, duration: event.duration);
      }
    });

    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= _scrollController.position.maxScrollExtent){
        viewModel.moreRequest();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _effectSubscription.cancel();
    searchCtrl.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final textTheme = Theme.of(context).textTheme;

    var loading = viewModel.status.isLoading ? LibProgressIndicator() : SizedBox.shrink();
    return Stack(
      children: [
        Visibility(
          visible: viewModel.status.search == '',
          child: Center(
            child: Text(
              'Busca tus libros o autores favoritos.',
              style: textTheme.titleBlack,
            )
          ),
          replacement: Visibility(
            visible: viewModel.status.numberList > 0,
            child: ListView.builder(
              controller: _scrollController,
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
                '''
                No se ha encontrado 
                ningun libro o artista 
                para la busqueda 
                ${viewModel.status.search}.''',
                style: textTheme.subtitleBlack,
              )
            ),
          ),
        ),
        loading
      ],
    );
  }

}