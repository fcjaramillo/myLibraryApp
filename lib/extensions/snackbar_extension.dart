import 'package:flutter/material.dart';
import 'package:mylibrary/commons/lib_colors.dart';

extension ShowSnackbar on BuildContext {

  void showErrorSnackbar({required String message, required int duration}){

    ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.warning,
                color: LibColors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(message),
            ],
          ),
          backgroundColor: LibColors.red,
          duration: Duration(seconds: duration),
        )
    );
  }

  void showSuccessSnackbar({required String message, required int duration}){

    ScaffoldMessenger.of(this).showSnackBar(
        SnackBar(
          content: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.done,
                  color: LibColors.greenAlert,
                  size: 25,
                ),
                decoration: ShapeDecoration(
                    color: LibColors.greenAlertBg,
                    shape: CircleBorder()
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                message,
                style: TextStyle(
                    color: LibColors.black,
                    fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          backgroundColor: LibColors.white,
          margin: EdgeInsets.all(12),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: duration),
        )
    );
  }
}