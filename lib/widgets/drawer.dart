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
          _createDrawerItem(context: context, icon: Icons.devices, color: LibColors.grayIcon, text: 'Buscar Libros', onTap: () => {onTap('search')}),
          _createDrawerItem(context: context, icon: Icons.devices_other, color: LibColors.grayIcon, text: 'Favoritos', onTap: () => {onTap('favorite')}),
          Divider(),
          //_createDrawerItem(context: context, icon: Icons.exit_to_app, color: LibColors.grayIcon, text: 'Cerrar sesión', onTap: onTapCloseSession),
        ],
      )
    );
  }

  Widget _createHeader(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return DrawerHeader(
        margin: EdgeInsets.zero,
        //margin: EdgeInsets.only(top: 8.0),
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              /*child: Image.asset(
                LibAssets.logo,
                width: MediaQuery.of(context).size.width * 0.4,
              ),*/
            ),
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
                'Taxis',
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
