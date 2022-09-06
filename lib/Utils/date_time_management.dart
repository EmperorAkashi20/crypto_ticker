import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeUtility {
  var now = DateTime.now();
  var dateFormatter = DateFormat('dd-MM-yyyy');
  var timeFormatter = DateFormat("HH:mm:ss");

  String parse({String? dateTime, String? returnFormat, String? parseFormat}) {
    if (dateTime == null) {
      return "";
    } else if (parseFormat != null) {
      DateTime formattedTime = DateFormat(parseFormat, "fr_FR").parse(dateTime);
      DateFormat dateFormat = DateFormat(returnFormat, "fr_FR");
      String returnDT = dateFormat.format(formattedTime);
      return returnDT;
    } else {
      DateTime dt = DateTime.parse(dateTime);
      DateFormat dateFormat = DateFormat(returnFormat, "fr_FR");
      String returnDT = dateFormat.format(dt);
      return returnDT;
    }
  }

  String getToday() {
    String formattedDate = dateFormatter.format(now);
    log(formattedDate);
    return formattedDate;
  }

  String getTimeNow() {
    String formattedTime = timeFormatter.format(now);
    log(formattedTime);
    return formattedTime;
  }

  String parseTime({String? dateTime, String? returnFormat}) {
    DateFormat dtFor = DateFormat("HH:mm:ss");
    DateTime dt = dtFor.parse(dateTime!);
    DateFormat dateFormat = DateFormat(returnFormat, "fr_FR");
    String returnDT = dateFormat.format(dt);
    return returnDT;
  }

  DateTime convertDateFromString(String strDate, {String? parseFormat}) {
    if (parseFormat != null) {
      DateFormat dateFormat = DateFormat(parseFormat, "fr_FR");
      DateTime todayDate = dateFormat.parse(strDate);
      return todayDate;
    } else {
      DateTime todayDate = DateTime.parse(strDate);
      return todayDate;
    }
  }

  String convertStringFromDatetime(
      {DateTime? date, String returnFormat = "yyyy-MM-dd"}) {
    DateFormat dateFormat = DateFormat(returnFormat, "fr_FR");
    String returnDT = dateFormat.format(date!);
    return returnDT;
  }

  String getTimeFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    debugPrint(timeInMillis);
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateTimeUtility()
        .parse(dateTime: date.toString(), returnFormat: "hh:mm a");
    return formattedDate;
  }

  String getDateFromTimeStamp(timeInMillis) {
    //int timeInMillis = 1586348737122;
    var date = DateTime.fromMillisecondsSinceEpoch(timeInMillis);
    String formattedDate = DateFormat.yMMMd().format(date);
    return formattedDate;
  }
}
