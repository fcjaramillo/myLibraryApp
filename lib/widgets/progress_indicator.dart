import 'package:flutter/material.dart';
import 'package:mylibrary/app_theme.dart';
import 'package:mylibrary/commons/lib_colors.dart';

class LibProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width/1.5,
          height: MediaQuery.of(context).size.width/1.7,
          decoration: BoxDecoration(
            color: LibColors.blueOpacity,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  backgroundColor: LibColors.white,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Text(
                  'Cargando...',
                  style: Theme.of(context).textTheme.textButtomWhite,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
