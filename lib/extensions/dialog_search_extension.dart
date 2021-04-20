import 'package:flutter/material.dart';
import 'package:mylibrary/commons/lib_colors.dart';
import 'package:mylibrary/app_theme.dart';

extension ShowDialogSearch on BuildContext {

  void showDialogSearch({
    required GlobalKey<FormState> keyForm,
    required TextEditingController searchCtl,
    required String? Function(String?) searchValidator,
    required VoidCallback onTapCancel,
    required VoidCallback onTapAccept,
  }){
    final textTheme = Theme.of(this).textTheme;

    showDialog(
      context: this,
      barrierColor: LibColors.blueOpacity,
      builder: (BuildContext context){
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      'Buscar Libros',
                      style: textTheme.titleBlack,
                    ),
                    SizedBox(height: 20),
                    Form(
                      key: keyForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.0,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Busca los libros por autor o por titulo',
                              alignLabelWithHint: true,
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: LibColors.gray)
                              )
                            ),
                            controller: searchCtl,
                            validator: searchValidator,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          child: Text(
                            'Cancelar',
                            style: TextStyle(
                              color: LibColors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(LibColors.gray),
                          ),
                          onPressed: onTapCancel,
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        OutlinedButton(
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                              color: LibColors.white,
                            ),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(LibColors.blueAccent),
                          ),
                          onPressed: onTapAccept,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );

  }

}