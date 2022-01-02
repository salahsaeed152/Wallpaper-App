import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wallpaper_application/shared/helper/enum.dart';

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

void showToast({
  required String text,
  required ShowToastColor stateColor,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: chooseToastColor(stateColor),
      textColor: Colors.white,
      fontSize: 16.0,
    );



Color chooseToastColor(ShowToastColor state) {
  Color color;

  switch (state) {
    case ShowToastColor.success:
      color = Colors.green;
      break;
    case ShowToastColor.error:
      color = Colors.red;
      break;
    case ShowToastColor.warning:
      color = Colors.amberAccent;
      break;
  }
  return color;
}


