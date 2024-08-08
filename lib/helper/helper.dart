


import 'package:cloud_firestore/cloud_firestore.dart';

String formatDate(Timestamp time){
  DateTime date = time.toDate();

  String year = date.year.toString();
  String month = date.month.toString();
  String day = date.day.toString();

  String combine = "$day/$month/$year";
  return combine;
}