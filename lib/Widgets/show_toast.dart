import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future showToast(
  String? message,
  String? messageType,
) {
  return Fluttertoast.showToast(
    timeInSecForIosWeb: 3,
    msg: message!,
    backgroundColor: messageType == 'success'
        ? Colors.green
        : messageType == 'error'
            ? Colors.red
            : Colors.white,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    textColor: messageType != 'success' && messageType != 'error'
        ? Colors.black
        : Colors.white,
    fontSize: 20.0,
  );
}
