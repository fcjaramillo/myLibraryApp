import 'package:flutter/material.dart';
import 'package:mylibrary/commons/lib_colors.dart';
import 'package:mylibrary/app_theme.dart';

class AppDrawer extends StatelessWidget {

  final void Function(String) onTap;
  final String userName;

  AppDrawer({required this.onTap, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(context),
          //Divider(),
          _createDrawerItem(context: context, icon: Icons.search, color: LibColors.blueAccent, text: 'Buscar Libros', onTap: () => {onTap('search')}),
          _createDrawerItem(context: context, icon: Icons.favorite, color: LibColors.red, text: 'Favoritos', onTap: () => {onTap('favorite')}),
          Divider(),
        ],
      )
    );
  }

  Widget _createHeader(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 6, right: 10),
              title: Text(
                userName,
                style: textTheme.subtitleBlack.copyWith(
                    fontWeight: FontWeight.w600
                ),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                'Mi Bliblioteca',
                style: TextStyle(
                    fontSize: 14
                ),
              ),
              leading: Icon(
                Icons.account_circle,
                color: LibColors.grayLight,
                size: 55,
              ),
            ),
          ],
        ));
  }

  Widget _createDrawerItem(
      {required BuildContext context, required IconData icon, required String text, required Color color, required void Function() onTap}) {

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.only(left: 6.0),
      child: ListTile(
        leading: Icon(
          icon,
          color: color,
        ),
        title: Text(
          text,
          style: textTheme.titleGray,
        ),
        onTap: onTap,
      ),
    );
  }

}
