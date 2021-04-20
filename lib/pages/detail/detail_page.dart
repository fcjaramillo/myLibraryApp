import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/commons/lib_colors.dart';
import 'package:mylibrary/configure/get_it_locator.dart';
import 'package:mylibrary/configure/lib_route.dart';
import 'package:mylibrary/pages/detail/detail_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mylibrary/app_theme.dart';

class DetailPage extends StatelessWidget {

  final BookModel _book;

  DetailPage(this._book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailViewModel(
        locator<LibRoute>()
      ),
      builder: (context, _){
        return DetailWidget(_book);
      },
    );
  }
}

class DetailWidget extends StatefulWidget {

  final BookModel book;

  DetailWidget(this.book);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {

  @override
  void initState() {
    final viewModel = context.read<DetailViewModel>();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      viewModel.onInit(widget.book);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;
    final viewModel = context.watch<DetailViewModel>();

    return Scaffold(
      backgroundColor: LibColors.white,
      appBar: AppBar(
        title: Text(
          viewModel.status.titleBar,
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              AspectRatio(
                aspectRatio: 1.7,
                child: Image.network(
                  'https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGlicmFyeXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'
                ),
              ),
            ],
          ),
          Positioned(
            top: (MediaQuery.of(context).size.width / 1.5) - 64.0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(
                  color: LibColors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: LibColors.grayLight.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 36.0
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Titulo del libro: ',
                        style: textTheme.titleBlack,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        viewModel.status.book.title!,
                        style: textTheme.subtitleblue,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Autores: ',
                        style: textTheme.titleBlack,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        viewModel.status.book.authorName.toString().substring(1, viewModel.status.book.authorName.toString().length - 1),
                        style: textTheme.subtitleblue,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Primer Año de Publicación: ',
                        style: textTheme.titleBlack,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        viewModel.status.book.firstPublishYear.toString(),
                        style: textTheme.subtitleblue,
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Key: ',
                        style: textTheme.titleBlack,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        viewModel.status.book.key!,
                        style: textTheme.subtitleblue,
                      ),

                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}