import 'package:flutter/material.dart';
import 'package:mylibrary/api/model/book_model.dart';
import 'package:mylibrary/commons/lib_colors.dart';
import 'package:mylibrary/app_theme.dart';

class BookCard extends StatelessWidget {

  final BookModel book;
  final VoidCallback onTap;
  final VoidCallback onTapStar;

  BookCard({required this.book, required this.onTap, required this.onTapStar});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 1, color: LibColors.grayChip,)
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      book.title!,
                      style: textTheme.titleBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      book.authorName.length > 0 ? book.authorName[0] : 'Sin Autores',
                      style: textTheme.subtitleBlack,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    /*Text(
                      request.asunto,
                      style: textTheme.titleGray,
                      overflow: TextOverflow.ellipsis,
                    ),*/
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  /*child: Icon(
                    iconStar,
                    color: color,
                    size: 28,
                  ),*/
                  child: Icon(
                    Icons.star_border,
                    size: 28,
                    color: LibColors.grayLight,
                  ),
                  onTap: onTapStar,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
